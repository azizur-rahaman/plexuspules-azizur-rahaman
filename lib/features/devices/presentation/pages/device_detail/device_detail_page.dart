import 'package:flutter/material.dart';
import 'package:plexuspules/features/devices/presentation/pages/device_detail/device_detail_view.dart';

class DeviceDetailPage extends StatelessWidget {
  final String deviceId;

  const DeviceDetailPage({
    super.key,
    required this.deviceId,
  });

  @override
  Widget build(BuildContext context) {
    return DeviceDetailView(deviceId: deviceId);
  }
}
