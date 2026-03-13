import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:plexuspules/features/devices/domain/usecases/get_device_details.dart';
import 'device_detail_event.dart';
import 'device_detail_state.dart';

@injectable
class DeviceDetailBloc extends Bloc<DeviceDetailEvent, DeviceDetailState> {
  final GetDeviceDetails _getDeviceDetails;
  Timer? _refreshTimer;

  DeviceDetailBloc(this._getDeviceDetails) : super(const DeviceDetailState()) {
    on<FetchDeviceDetail>(_onFetchDeviceDetail);
    on<RefreshDeviceDetail>(_onRefreshDeviceDetail);
  }

  Future<void> _onFetchDeviceDetail(
    FetchDeviceDetail event,
    Emitter<DeviceDetailState> emit,
  ) async {
    emit(state.copyWith(status: DeviceDetailStatus.loading));
    
    final result = await _getDeviceDetails(event.deviceId);

    result.fold(
      (failure) => emit(state.copyWith(
        status: DeviceDetailStatus.error,
        message: failure.message,
      )),
      (device) {
        emit(state.copyWith(
          status: DeviceDetailStatus.success,
          device: device,
        ));
        _startRefreshTimer(event.deviceId);
      },
    );
  }

  Future<void> _onRefreshDeviceDetail(
    RefreshDeviceDetail event,
    Emitter<DeviceDetailState> emit,
  ) async {
    final result = await _getDeviceDetails(event.deviceId);

    result.fold(
      (failure) => null, // Silently fail on refresh
      (device) => emit(state.copyWith(
        status: DeviceDetailStatus.success,
        device: device,
      )),
    );
  }

  void _startRefreshTimer(String deviceId) {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      add(RefreshDeviceDetail(deviceId));
    });
  }

  @override
  Future<void> close() {
    _refreshTimer?.cancel();
    return super.close();
  }
}
