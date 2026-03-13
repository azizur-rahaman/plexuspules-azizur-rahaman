import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plexuspules/core/constants/app_sizes.dart';
import 'package:plexuspules/features/dashboard/presentation/widgets/stat_card.dart';
import 'package:plexuspules/features/dashboard/presentation/widgets/alert_item.dart';
import 'package:plexuspules/core/widgets/common_app_bar.dart';
import '../../bloc/dashboard_bloc.dart';
import '../../bloc/dashboard_event.dart';
import '../../bloc/dashboard_state.dart';

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
      // Potentially show critical alert if state has one, but keep mock for now or remove
      // _showCriticalAlert();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CommonAppBar.brand(),
      body: SafeArea(
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is DashboardError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.message}'),
                    AppSizes.gap16,
                    ElevatedButton(
                      onPressed: () => context.read<DashboardBloc>().add(
                        const FetchDashboardMetrics(),
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is DashboardLoaded) {
              final metrics = state.metrics;
              return SingleChildScrollView(
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
                          value: metrics.totalDevices.toString(),
                          subtitle: 'Total connected devices',
                          icon: Icons.inventory_2_outlined,
                          color: Colors.blue,
                        ),
                        StatCard(
                          title: 'ONLINE',
                          value: metrics.onlineDevices.toString(),
                          subtitle: 'Currently active',
                          icon: Icons.cloud_done_outlined,
                          color: Colors.green,
                        ),
                        StatCard(
                          title: 'OFFLINE',
                          value: metrics.offlineDevices.toString(),
                          subtitle: 'Action required',
                          icon: Icons.cloud_off_outlined,
                          color: Colors.red,
                        ),
                        StatCard(
                          title: 'ALERTS',
                          value: metrics.alerts.toString(),
                          subtitle: 'Open issues',
                          icon: Icons.warning_amber_outlined,
                          color: Colors.orange,
                        ),
                      ],
                    ),
                    AppSizes.gap32,

                    // // Network Health
                    // NetworkHealthCard(
                    //   percentage: metrics.totalDevices > 0
                    //     ? (metrics.onlineDevices / metrics.totalDevices * 100).round()
                    //     : 0,
                    //   latency: '14ms', // Still mock or can add to metrics
                    //   status: 'Stable',
                    // ),
                    AppSizes.gap32,

                    // Recent Alerts Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Alerts',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                    AppSizes.gap16,

                    // Recent Alerts List — Keep mock for now or implement AlertBloc
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
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
