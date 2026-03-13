// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModel _$DeviceModelFromJson(Map<String, dynamic> json) => DeviceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String? ?? 'Unknown',
      status: $enumDecode(_$DeviceStatusEnumMap, json['status']),
      location: json['location'] as String,
      ipAddress: json['ipAddress'] as String,
      lastSeen: DateTime.parse(json['lastPing'] as String),
      cpuUsage: (json['cpuUsage'] as num?)?.toDouble(),
      memoryUsage: (json['memoryUsage'] as num?)?.toDouble(),
      performanceHistory: (json['performanceHistory'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$DeviceModelToJson(DeviceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'status': _$DeviceStatusEnumMap[instance.status]!,
      'location': instance.location,
      'ipAddress': instance.ipAddress,
      'lastPing': instance.lastSeen.toIso8601String(),
      'cpuUsage': instance.cpuUsage,
      'memoryUsage': instance.memoryUsage,
      'performanceHistory': instance.performanceHistory,
    };

const _$DeviceStatusEnumMap = {
  DeviceStatus.online: 'online',
  DeviceStatus.offline: 'offline',
  DeviceStatus.maintenance: 'maintenance',
};

T $enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: ${enumValues.values.join(', ')}'))
      .key;
  return value;
}
