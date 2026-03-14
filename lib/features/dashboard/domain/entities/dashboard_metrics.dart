import 'package:equatable/equatable.dart';

class DashboardMetrics extends Equatable {
  final int totalDevices;
  final int onlineDevices;
  final int offlineDevices;
  final int alerts;
  final double? cpuUsage;
  final double? memoryUsage;
  final double? networkTraffic;
  final List<double>? cpuHistory;
  final List<double>? memoryHistory;

  const DashboardMetrics({
    required this.totalDevices,
    required this.onlineDevices,
    required this.offlineDevices,
    required this.alerts,
    this.cpuUsage,
    this.memoryUsage,
    this.networkTraffic,
    this.cpuHistory,
    this.memoryHistory,
  });

  @override
  List<Object?> get props => [
    totalDevices,
    onlineDevices,
    offlineDevices,
    alerts,
    cpuUsage,
    memoryUsage,
    networkTraffic,
    cpuHistory,
    memoryHistory,
  ];
}
