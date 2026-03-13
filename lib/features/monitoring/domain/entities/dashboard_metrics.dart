import 'package:equatable/equatable.dart';

class DashboardMetrics extends Equatable {
  final int totalDevices;
  final int onlineDevices;
  final int offlineDevices;
  final int alerts;
  final double cpuUsage;
  final double memoryUsage;
  final double networkTraffic;
  final List<double>? performanceHistory;

  const DashboardMetrics({
    required this.totalDevices,
    required this.onlineDevices,
    required this.offlineDevices,
    required this.alerts,
    required this.cpuUsage,
    required this.memoryUsage,
    required this.networkTraffic,
    this.performanceHistory,
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
    performanceHistory,
  ];
}
