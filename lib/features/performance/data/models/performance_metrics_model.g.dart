// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_metrics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerformanceMetricsModel _$PerformanceMetricsModelFromJson(
  Map<String, dynamic> json,
) => PerformanceMetricsModel(
  cpuUsage: (json['cpuUsage'] as num).toDouble(),
  memoryUsage: (json['memoryUsage'] as num).toDouble(),
  networkTraffic: (json['networkTraffic'] as num).toDouble(),
  cpuHistory: (json['cpuHistory'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
  memoryHistory: (json['memoryHistory'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
);

Map<String, dynamic> _$PerformanceMetricsModelToJson(
  PerformanceMetricsModel instance,
) => <String, dynamic>{
  'cpuUsage': instance.cpuUsage,
  'memoryUsage': instance.memoryUsage,
  'networkTraffic': instance.networkTraffic,
  'cpuHistory': instance.cpuHistory,
  'memoryHistory': instance.memoryHistory,
};
