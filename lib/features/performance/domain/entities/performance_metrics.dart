import 'package:equatable/equatable.dart';

class PerformanceMetrics extends Equatable {
  final double cpuUsage;
  final double memoryUsage;
  final double networkTraffic;
  final List<double> cpuHistory;
  final List<double> memoryHistory;

  const PerformanceMetrics({
    required this.cpuUsage,
    required this.memoryUsage,
    required this.networkTraffic,
    required this.cpuHistory,
    required this.memoryHistory,
  });

  @override
  List<Object?> get props => [cpuUsage, memoryUsage, networkTraffic, cpuHistory, memoryHistory];
}
