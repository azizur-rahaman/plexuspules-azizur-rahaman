import 'package:equatable/equatable.dart';

enum DeviceStatus {
  online,
  offline,
  maintenance,
}

class Device extends Equatable {
  final String id;
  final String name;
  final String type;
  final DeviceStatus status;
  final String location;
  final String ipAddress;
  final DateTime lastSeen;
  final double? cpuUsage;
  final double? memoryUsage;
  final List<double>? performanceHistory;

  const Device({
    required this.id,
    required this.name,
    this.type = 'Unknown',
    required this.status,
    required this.location,
    required this.ipAddress,
    required this.lastSeen,
    this.cpuUsage,
    this.memoryUsage,
    this.performanceHistory,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        status,
        location,
        ipAddress,
        lastSeen,
        cpuUsage,
        memoryUsage,
        performanceHistory,
      ];
}
