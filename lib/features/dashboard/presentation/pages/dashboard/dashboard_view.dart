import 'package:flutter/material.dart';
import 'package:plexuspules/core/constants/app_sizes.dart';
import 'package:plexuspules/features/dashboard/presentation/widgets/stat_card.dart';
import 'package:plexuspules/features/dashboard/presentation/widgets/network_health_card.dart';
import 'package:plexuspules/features/dashboard/presentation/widgets/alert_item.dart';
import 'package:plexuspules/features/alerts/presentation/widgets/critical_alert_popup.dart';
import 'package:plexuspules/core/widgets/common_app_bar.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showCriticalAlert();
    });
  }

  void _showCriticalAlert() {
    CriticalAlertPopup.show(
      context,
      deviceName: 'Router-01',
      ipAddress: '192.168.1.50',
      location: 'Data Center A',
      timeDetected: 'Just now',
      onViewDevice: () {
        // TODO: Navigate to device details
      },
      onDismiss: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CommonAppBar.brand(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: AppSizes.p16,
                crossAxisSpacing: AppSizes.p16,
                childAspectRatio: 1.1,
                children: [
                  StatCard(
                    title: 'TOTAL',
                    value: '1,284',
                    subtitle: 'Inventory updated 2m ago',
                    icon: Icons.inventory_2_outlined,
                    color: Colors.blue,
                  ),
                  StatCard(
                    title: 'ONLINE',
                    value: '1,256',
                    subtitle: '+1.2% from peak',
                    icon: Icons.cloud_done_outlined,
                    color: Colors.green,
                  ),
                  StatCard(
                    title: 'OFFLINE',
                    value: '28',
                    subtitle: '-4 since yesterday',
                    icon: Icons.cloud_off_outlined,
                    color: Colors.red,
                  ),
                  StatCard(
                    title: 'ALERTS',
                    value: '12',
                    subtitle: '3 High Priority',
                    icon: Icons.warning_amber_outlined,
                    color: Colors.orange,
                  ),
                ],
              ),
              AppSizes.gap32,

              // Network Health
              const NetworkHealthCard(
                percentage: 98,
                latency: '14ms',
                status: 'Stable',
              ),
              AppSizes.gap32,

              // Recent Alerts Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Alerts',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(onPressed: () {}, child: const Text('View All')),
                ],
              ),
              AppSizes.gap16,

              // Recent Alerts List
              const AlertItem(
                title: 'Node-412 Disconnected',
                subtitle: 'Singapore Region • DB Cluster',
                time: '2m ago',
                type: AlertType.critical,
              ),
              AppSizes.gap12,
              const AlertItem(
                title: 'High CPU Usage',
                subtitle: 'US-East Edge Proxy',
                time: '15m ago',
                type: AlertType.warning,
              ),
              AppSizes.gap12,
              const AlertItem(
                title: 'Update Completed',
                subtitle: 'Core Engine v2.4.1',
                time: '1h ago',
                type: AlertType.info,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
