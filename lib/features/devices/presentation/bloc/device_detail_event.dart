import 'package:equatable/equatable.dart';

abstract class DeviceDetailEvent extends Equatable {
  const DeviceDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchDeviceDetail extends DeviceDetailEvent {
  final String deviceId;

  const FetchDeviceDetail(this.deviceId);

  @override
  List<Object> get props => [deviceId];
}

class RefreshDeviceDetail extends DeviceDetailEvent {
  final String deviceId;

  const RefreshDeviceDetail(this.deviceId);

  @override
  List<Object> get props => [deviceId];
}
