import 'dart:async';
import 'package:equatable/equatable.dart';

abstract class AlertsEvent extends Equatable {
  const AlertsEvent();

  @override
  List<Object?> get props => [];
}

class FetchAlerts extends AlertsEvent {
  final Completer<void>? completer;
  const FetchAlerts({this.completer});

  @override
  List<Object?> get props => [completer];
}
