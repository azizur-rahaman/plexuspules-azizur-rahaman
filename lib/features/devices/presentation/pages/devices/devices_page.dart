import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plexuspules/core/di/injection.dart';
import '../../bloc/devices_bloc.dart';
import '../../bloc/devices_event.dart';
import 'devices_view.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DevicesBloc>()..add(const FetchDevices()),
      child: const DevicesView(),
    );
  }
}
