import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/performance_metrics.dart';

part 'performance_metrics_model.g.dart';

@JsonSerializable()
class PerformanceMetricsModel extends PerformanceMetrics {
  const PerformanceMetricsModel({
    required super.cpuUsage,
    required super.memoryUsage,
    required super.networkTraffic,
    required super.cpuHistory,
    required super.memoryHistory,
  });

  factory PerformanceMetricsModel.fromJson(Map<String, dynamic> json) =>
      _$PerformanceMetricsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceMetricsModelToJson(this);
}
