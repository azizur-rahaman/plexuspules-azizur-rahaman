import 'package:flutter/material.dart';
import 'package:plexuspules/config/theme/app_colors.dart';
import 'package:plexuspules/core/constants/app_sizes.dart';
import 'package:plexuspules/core/widgets/common_app_bar.dart';
import 'package:plexuspules/features/monitoring/domain/entities/device.dart';
import 'package:plexuspules/features/devices/presentation/widgets/device_card.dart';
import 'package:plexuspules/features/devices/presentation/widgets/device_status_card.dart';
import 'package:plexuspules/features/devices/presentation/widgets/circular_usage_card.dart';
import 'package:plexuspules/features/devices/presentation/widgets/performance_graph.dart';

class DeviceDetailView extends StatelessWidget {
  final String deviceId;

  const DeviceDetailView({super.key, required this.deviceId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // In a real app, we'd fetch device data based on deviceId
    const deviceName = 'Core-Switch-01';
    const ipAddress = '192.168.1.1';
    const location = 'Singapore DC';
    const lastPing = '2s ago';
    const status = DeviceStatus.online;
    const icon = Icons.router_outlined;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CommonAppBar.brand(showBottomBorder: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DeviceStatusCard(
                name: deviceName,
                ipAddress: ipAddress,
                location: location,
                lastPing: lastPing,
                status: status,
                icon: icon,
              ),
              AppSizes.gap20,
              Row(
                children: [
                  Expanded(
                    child: CircularUsageCard(
                      title: 'CPU USAGE',
                      progress: 0.24,
                      trend: '-2% (1hr)',
                      progressColor: Colors.blue,
                    ),
                  ),
                  AppSizes.gap16,
                  Expanded(
                    child: CircularUsageCard(
                      title: 'MEMORY',
                      progress: 0.68,
                      trend: '+5% (1hr)',
                      progressColor: AppColors.healthy,
                      isTrendPositive: true,
                    ),
                  ),
                ],
              ),
              AppSizes.gap20,
              const PerformanceGraph(),
              AppSizes.gap24, // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
