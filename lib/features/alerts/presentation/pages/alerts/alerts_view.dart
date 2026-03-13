import 'package:flutter/material.dart';
import 'package:plexuspules/core/widgets/common_app_bar.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../domain/entities/alert.dart';
import '../../widgets/alert_card.dart';
import '../../widgets/filter_chip_group.dart';

class AlertsView extends StatefulWidget {
  const AlertsView({super.key});

  @override
  State<AlertsView> createState() => _AlertsViewState();
}

class _AlertsViewState extends State<AlertsView> {
  final List<Alert> _allAlerts = [
    Alert(
      id: '1',
      title: 'Core-Switch-01',
      description: 'High Latency Detected on Uplink Port 48',
      severity: AlertSeverity.critical,
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    Alert(
      id: '2',
      title: 'Edge-Router-05',
      description: 'BGP Session Dropped with AS64512',
      severity: AlertSeverity.alert,
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    Alert(
      id: '3',
      title: 'Storage-Node-Alpha',
      description: 'Disk utilization exceeds 85% threshold',
      severity: AlertSeverity.warning,
      timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
    ),
    Alert(
      id: '4',
      title: 'VPN-Gateway-Secondary',
      description: 'Scheduled maintenance window starting soon',
      severity: AlertSeverity.info,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Alert(
      id: '5',
      title: 'Wifi-AP-Lobby-02',
      description: 'Unusually high client density detected',
      severity: AlertSeverity.alert,
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    ),
  ];

  String _currentFilter = 'All Alerts';

  @override
  Widget build(BuildContext context) {
    final filteredAlerts = _allAlerts.where((alert) {
      if (_currentFilter == 'All Alerts') return true;
      if (_currentFilter == 'Critical') {
        return alert.severity == AlertSeverity.critical;
      }
      if (_currentFilter == 'Warnings') {
        return alert.severity == AlertSeverity.warning ||
            alert.severity == AlertSeverity.alert;
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: CommonAppBar.brand(showBottomBorder: true, hideAlerts: true),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(AppSizes.p20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSizes.gap24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Active Alerts',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.p12,
                          vertical: AppSizes.p4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F3ED),
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusCircular,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            AppSizes.gap8,
                            Text(
                              'LIVE',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: AppSizes.font12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AppSizes.gap20,
                  FilterChipGroup(
                    filters: const ['All Alerts', 'Critical', 'Warnings'],
                    onFilterSelected: (filter) {
                      setState(() {
                        _currentFilter = filter;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.p20),
                itemCount: filteredAlerts.length,
                itemBuilder: (context, index) {
                  return AlertCard(
                    alert: filteredAlerts[index],
                    onAcknowledge: () {},
                    onViewDetails: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
