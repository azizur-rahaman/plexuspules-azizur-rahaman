import 'dart:async';
import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class FetchDashboardMetrics extends DashboardEvent {
  const FetchDashboardMetrics();
}

class RefreshDashboardMetrics extends DashboardEvent {
  final Completer<void>? completer;
  const RefreshDashboardMetrics({this.completer});

  @override
  List<Object?> get props => [completer];
}
