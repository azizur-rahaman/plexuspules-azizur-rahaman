import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_alerts.dart';
import 'alerts_event.dart';
import 'alerts_state.dart';

@injectable
class AlertsBloc extends Bloc<AlertsEvent, AlertsState> {
  final GetAlerts _getAlerts;
  Timer? _pollingTimer;

  AlertsBloc(this._getAlerts) : super(AlertsInitial()) {
    on<FetchAlerts>(_onFetchAlerts);
    
    // Start polling when the bloc is created
    _startPolling();
  }

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      add(FetchAlerts());
    });
  }

  Future<void> _onFetchAlerts(
    FetchAlerts event,
    Emitter<AlertsState> emit,
  ) async {
    if (state is! AlertsLoaded) {
      emit(AlertsLoading());
    }

    final result = await _getAlerts();

    result.fold(
      (failure) => emit(AlertsError(failure.message)),
      (alerts) => emit(AlertsLoaded(alerts)),
    );
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }
}
