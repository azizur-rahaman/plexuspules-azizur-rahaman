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
  const RefreshDashboardMetrics();
}
