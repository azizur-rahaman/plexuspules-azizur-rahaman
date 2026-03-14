import 'package:equatable/equatable.dart';

class PerformanceMetrics extends Equatable {
  final double? cpuUsage;
  final double? memoryUsage;
  final double? networkTraffic;
  final List<double>? cpuHistory;
  final List<double>? memoryHistory;

  const PerformanceMetrics({
    this.cpuUsage,
    this.memoryUsage,
    this.networkTraffic,
    this.cpuHistory,
    this.memoryHistory,
  });

  @override
  List<Object?> get props => [cpuUsage, memoryUsage, networkTraffic, cpuHistory, memoryHistory];
}
