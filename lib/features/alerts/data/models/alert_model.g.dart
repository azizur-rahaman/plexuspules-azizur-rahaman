// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlertModel _$AlertModelFromJson(Map<String, dynamic> json) => AlertModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  severity: $enumDecode(_$AlertSeverityEnumMap, json['severity']),
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$AlertModelToJson(AlertModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'severity': _$AlertSeverityEnumMap[instance.severity]!,
      'timestamp': instance.timestamp.toIso8601String(),
    };

const _$AlertSeverityEnumMap = {
  AlertSeverity.critical: 'critical',
  AlertSeverity.alert: 'alert',
  AlertSeverity.warning: 'warning',
  AlertSeverity.info: 'info',
};
