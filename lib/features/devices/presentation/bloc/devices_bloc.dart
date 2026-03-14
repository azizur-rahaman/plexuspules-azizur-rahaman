import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:plexuspules/features/devices/domain/usecases/get_devices.dart';
import 'devices_event.dart';
import 'devices_state.dart';

const _pageSize = 10;
const _throttleDuration = Duration(milliseconds: 500);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return events.throttle(duration).switchMap(mapper);
  };
}

@injectable
class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  final GetDevices _getDevices;

  Timer? _pollingTimer;

  DevicesBloc(this._getDevices) : super(const DevicesState()) {
    on<FetchDevices>(_onFetchDevices);
    on<LoadMoreDevices>(
      _onLoadMoreDevices,
      transformer: throttleDroppable(_throttleDuration),
    );
    on<ChangeFilter>(_onChangeFilter);
    on<SearchChanged>(
      _onSearchChanged,
      transformer: throttleDroppable(const Duration(milliseconds: 300)),
    );
    
    // Start polling every 10 seconds
    _startPolling();
  }

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (state.status == DevicesStatus.success) {
        add(const FetchDevices());
      }
    });
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }

  Future<void> _onFetchDevices(
    FetchDevices event,
    Emitter<DevicesState> emit,
  ) async {
    emit(state.copyWith(status: DevicesStatus.loading, devices: []));
    
    final result = await _getDevices(GetDevicesParams(
      page: 1,
      limit: _pageSize,
      search: state.searchQuery,
      status: state.statusFilter?.name,
    ));

    result.fold(
      (failure) => emit(state.copyWith(status: DevicesStatus.error, message: failure.message)),
      (devices) => emit(state.copyWith(
        status: DevicesStatus.success,
        devices: devices,
        hasReachedMax: devices.length < _pageSize,
      )),
    );
  }

  Future<void> _onLoadMoreDevices(
    LoadMoreDevices event,
    Emitter<DevicesState> emit,
  ) async {
    if (state.hasReachedMax || state.status == DevicesStatus.loading) return;

    final nextPage = (state.devices.length ~/ _pageSize) + 1;
    final result = await _getDevices(GetDevicesParams(
      page: nextPage,
      limit: _pageSize,
      search: state.searchQuery,
      status: state.statusFilter?.name,
    ));

    result.fold(
      (failure) => null, // Silently fail for load more
      (newDevices) {
        emit(state.copyWith(
          devices: List.of(state.devices)..addAll(newDevices),
          hasReachedMax: newDevices.length < _pageSize,
        ));
      },
    );
  }

  Future<void> _onChangeFilter(
    ChangeFilter event,
    Emitter<DevicesState> emit,
  ) async {
    emit(state.copyWith(
      status: DevicesStatus.loading, 
      statusFilter: event.status, 
      clearFilter: event.status == null,
      devices: [],
    ));
    
    final result = await _getDevices(GetDevicesParams(
      page: 1,
      limit: _pageSize,
      status: event.status?.name,
      search: state.searchQuery,
    ));

    result.fold(
      (failure) => emit(state.copyWith(status: DevicesStatus.error, message: failure.message)),
      (devices) => emit(state.copyWith(
        status: DevicesStatus.success,
        devices: devices,
        hasReachedMax: devices.length < _pageSize,
      )),
    );
  }

  Future<void> _onSearchChanged(
    SearchChanged event,
    Emitter<DevicesState> emit,
  ) async {
    emit(state.copyWith(
      status: DevicesStatus.loading, 
      searchQuery: event.search,
      clearSearch: event.search.isEmpty,
      devices: [],
    ));

    final result = await _getDevices(GetDevicesParams(
      page: 1,
      limit: _pageSize,
      search: event.search.isEmpty ? null : event.search,
      status: state.statusFilter?.name,
    ));

    result.fold(
      (failure) => emit(state.copyWith(status: DevicesStatus.error, message: failure.message)),
      (devices) => emit(state.copyWith(
        status: DevicesStatus.success,
        devices: devices,
        hasReachedMax: devices.length < _pageSize,
      )),
    );
  }
}
