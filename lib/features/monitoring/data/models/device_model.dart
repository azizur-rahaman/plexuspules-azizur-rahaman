import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/device.dart';

part 'device_model.g.dart';

@JsonSerializable()
class DeviceModel extends Device {
  const DeviceModel({
    required super.id,
    required super.name,
    super.type,
    required super.status,
    required super.location,
    required super.ipAddress,
    @JsonKey(name: 'lastPing') required DateTime lastSeen,
    super.cpuUsage,
    super.memoryUsage,
    super.performanceHistory,
  }) : super(lastSeen: lastSeen);

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceModelToJson(this);
}
