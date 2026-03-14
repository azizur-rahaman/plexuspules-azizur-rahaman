import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/performance_metrics.dart';

part 'performance_metrics_model.g.dart';

@JsonSerializable()
class PerformanceMetricsModel extends PerformanceMetrics {
  const PerformanceMetricsModel({
    super.cpuUsage,
    super.memoryUsage,
    super.networkTraffic,
    super.cpuHistory,
    super.memoryHistory,
  });

  factory PerformanceMetricsModel.fromJson(Map<String, dynamic> json) =>
      _$PerformanceMetricsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PerformanceMetricsModelToJson(this);
}
