import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:plexuspules/features/dashboard/domain/usecases/get_dashboard_metrics.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardMetrics _getDashboardMetrics;
  Timer? _pollingTimer;

  DashboardBloc(this._getDashboardMetrics) : super(const DashboardInitial()) {
    on<FetchDashboardMetrics>(_onFetchMetrics);
    on<RefreshDashboardMetrics>(_onRefreshMetrics);
  }

  Future<void> _onFetchMetrics(
    FetchDashboardMetrics event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardLoading());
    await _fetchData(emit);
    _startPolling();
  }

  Future<void> _onRefreshMetrics(
    RefreshDashboardMetrics event,
    Emitter<DashboardState> emit,
  ) async {
    await _fetchData(emit);
    event.completer?.complete();
  }

  Future<void> _fetchData(Emitter<DashboardState> emit) async {
    final result = await _getDashboardMetrics();
    result.fold(
      (failure) => emit(DashboardError(failure.message)),
      (metrics) => emit(DashboardLoaded(metrics)),
    );
  }

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      add(const RefreshDashboardMetrics());
    });
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }
}
