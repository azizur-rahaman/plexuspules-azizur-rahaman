// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_metrics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardMetricsModel _$DashboardMetricsModelFromJson(
  Map<String, dynamic> json,
) => DashboardMetricsModel(
  totalDevices: (json['totalDevices'] as num).toInt(),
  onlineDevices: (json['onlineDevices'] as num).toInt(),
  offlineDevices: (json['offlineDevices'] as num).toInt(),
  alerts: (json['alerts'] as num).toInt(),
  cpuUsage: (json['cpuUsage'] as num).toDouble(),
  memoryUsage: (json['memoryUsage'] as num).toDouble(),
  networkTraffic: (json['networkTraffic'] as num).toDouble(),
  performanceHistory: (json['performanceHistory'] as List<dynamic>?)
      ?.map((e) => (e as num).toDouble())
      .toList(),
);

Map<String, dynamic> _$DashboardMetricsModelToJson(
  DashboardMetricsModel instance,
) => <String, dynamic>{
  'totalDevices': instance.totalDevices,
  'onlineDevices': instance.onlineDevices,
  'offlineDevices': instance.offlineDevices,
  'alerts': instance.alerts,
  'cpuUsage': instance.cpuUsage,
  'memoryUsage': instance.memoryUsage,
  'networkTraffic': instance.networkTraffic,
  'performanceHistory': instance.performanceHistory,
};
