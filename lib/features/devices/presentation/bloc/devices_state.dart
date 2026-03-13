import 'package:equatable/equatable.dart';
import 'package:plexuspules/features/devices/domain/entities/device.dart';

enum DevicesStatus { initial, loading, success, error }

class DevicesState extends Equatable {
  final List<Device> devices;
  final DevicesStatus status;
  final String? message;
  final bool hasReachedMax;
  final String? searchQuery;
  final DeviceStatus? statusFilter;

  const DevicesState({
    this.devices = const [],
    this.status = DevicesStatus.initial,
    this.message,
    this.hasReachedMax = false,
    this.searchQuery,
    this.statusFilter,
  });

  DevicesState copyWith({
    List<Device>? devices,
    DevicesStatus? status,
    String? message,
    bool? hasReachedMax,
    String? searchQuery,
    DeviceStatus? statusFilter,
    bool clearSearch = false,
    bool clearFilter = false,
  }) {
    return DevicesState(
      devices: devices ?? this.devices,
      status: status ?? this.status,
      message: message ?? this.message,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchQuery: clearSearch ? null : (searchQuery ?? this.searchQuery),
      statusFilter: clearFilter ? null : (statusFilter ?? this.statusFilter),
    );
  }

  @override
  List<Object?> get props => [
        devices,
        status,
        message,
        hasReachedMax,
        searchQuery,
        statusFilter,
      ];
}
