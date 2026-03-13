import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_performance_metrics.dart';
import 'performance_event.dart';
import 'performance_state.dart';

@injectable
class PerformanceBloc extends Bloc<PerformanceEvent, PerformanceState> {
  final GetPerformanceMetrics _getPerformanceMetrics;
  Timer? _pollingTimer;

  PerformanceBloc(this._getPerformanceMetrics) : super(PerformanceInitial()) {
    on<FetchPerformanceMetrics>(_onFetchPerformanceMetrics);
    
    // Start polling when the bloc is created
    _startPolling();
  }

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      add(FetchPerformanceMetrics());
    });
  }

  Future<void> _onFetchPerformanceMetrics(
    FetchPerformanceMetrics event,
    Emitter<PerformanceState> emit,
  ) async {
    if (state is! PerformanceLoaded) {
      emit(PerformanceLoading());
    }

    final result = await _getPerformanceMetrics();

    result.fold(
      (failure) => emit(PerformanceError(failure.message)),
      (metrics) => emit(PerformanceLoaded(metrics)),
    );
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }
}
