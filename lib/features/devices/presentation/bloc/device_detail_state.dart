import 'package:equatable/equatable.dart';
import '../../../monitoring/domain/entities/device.dart';

enum DeviceDetailStatus { initial, loading, success, error }

class DeviceDetailState extends Equatable {
  final DeviceDetailStatus status;
  final Device? device;
  final String? message;

  const DeviceDetailState({
    this.status = DeviceDetailStatus.initial,
    this.device,
    this.message,
  });

  DeviceDetailState copyWith({
    DeviceDetailStatus? status,
    Device? device,
    String? message,
  }) {
    return DeviceDetailState(
      status: status ?? this.status,
      device: device ?? this.device,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, device, message];
}
