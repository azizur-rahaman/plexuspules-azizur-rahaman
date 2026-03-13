import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/dashboard_metrics.dart';

part 'dashboard_metrics_model.g.dart';

@JsonSerializable()
class DashboardMetricsModel extends DashboardMetrics {
  const DashboardMetricsModel({
    required super.totalDevices,
    required super.onlineDevices,
    required super.offlineDevices,
    required super.alerts,
    required super.cpuUsage,
    required super.memoryUsage,
    required super.networkTraffic,
    super.cpuHistory,
    super.memoryHistory,
  });

  factory DashboardMetricsModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardMetricsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardMetricsModelToJson(this);
}
