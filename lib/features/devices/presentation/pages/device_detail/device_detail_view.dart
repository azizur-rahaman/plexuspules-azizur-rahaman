import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plexuspules/config/theme/app_colors.dart';
import 'package:plexuspules/core/constants/app_sizes.dart';
import 'package:plexuspules/core/widgets/common_app_bar.dart';
import 'package:plexuspules/features/devices/presentation/widgets/device_status_card.dart';
import 'package:plexuspules/features/devices/presentation/widgets/circular_usage_card.dart';
import 'package:plexuspules/features/devices/presentation/widgets/performance_graph.dart';
import '../../bloc/device_detail_bloc.dart';
import '../../bloc/device_detail_state.dart';

class DeviceDetailView extends StatelessWidget {
  final String deviceId;

  const DeviceDetailView({super.key, required this.deviceId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CommonAppBar.brand(showBottomBorder: false),
      body: SafeArea(
        child: BlocBuilder<DeviceDetailBloc, DeviceDetailState>(
          builder: (context, state) {
            if (state.status == DeviceDetailStatus.loading && state.device == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == DeviceDetailStatus.error && state.device == null) {
              return Center(child: Text('Error: ${state.message}'));
            }

            final device = state.device;
            if (device == null) {
              return const Center(child: Text('Device not found'));
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(AppSizes.p20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DeviceStatusCard(
                    name: device.name,
                    ipAddress: device.ipAddress,
                    location: device.location,
                    lastPing: _formatLastSeen(device.lastSeen),
                    status: device.status,
                    icon: Icons.router_outlined,
                  ),
                  AppSizes.gap20,
                  Row(
                    children: [
                      Expanded(
                        child: CircularUsageCard(
                          title: 'CPU USAGE',
                          progress: (device.cpuUsage ?? 0) / 100,
                          trend: 'Real-time',
                          progressColor: (device.cpuUsage ?? 0) > 80 ? AppColors.critical : Colors.blue,
                        ),
                      ),
                      AppSizes.gap16,
                      Expanded(
                        child: CircularUsageCard(
                          title: 'MEMORY',
                          progress: (device.memoryUsage ?? 0) / 100,
                          trend: 'Real-time',
                          progressColor: (device.memoryUsage ?? 0) > 80 ? AppColors.critical : AppColors.healthy,
                          isTrendPositive: true,
                        ),
                      ),
                    ],
                  ),
                  AppSizes.gap20,
                  PerformanceGraph(
                    title: 'Overall Performance',
                    history: device.performanceHistory,
                  ),
                  AppSizes.gap24, // Bottom padding
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _formatLastSeen(DateTime lastSeen) {
    final difference = DateTime.now().difference(lastSeen);
    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else {
      return '${difference.inHours}h ago';
    }
  }
}
