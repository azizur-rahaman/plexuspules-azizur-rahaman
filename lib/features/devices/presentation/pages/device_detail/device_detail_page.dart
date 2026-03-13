import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plexuspules/core/di/injection.dart';
import 'package:plexuspules/features/devices/presentation/bloc/device_detail_bloc.dart';
import 'package:plexuspules/features/devices/presentation/bloc/device_detail_event.dart';
import 'package:plexuspules/features/devices/presentation/pages/device_detail/device_detail_view.dart';

class DeviceDetailPage extends StatelessWidget {
  final String deviceId;

  const DeviceDetailPage({
    super.key,
    required this.deviceId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DeviceDetailBloc>()..add(FetchDeviceDetail(deviceId)),
      child: DeviceDetailView(deviceId: deviceId),
    );
  }
}
