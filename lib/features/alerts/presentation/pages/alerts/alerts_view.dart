import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plexuspules/core/widgets/common_app_bar.dart';
import 'package:plexuspules/features/alerts/presentation/bloc/alerts_bloc.dart';
import 'package:plexuspules/features/alerts/presentation/bloc/alerts_event.dart';
import 'package:plexuspules/features/alerts/presentation/bloc/alerts_state.dart';
import 'package:plexuspules/core/di/injection.dart';
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
  String _currentFilter = 'All Alerts';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AlertsBloc>()..add(FetchAlerts()),
      child: Scaffold(
        appBar: CommonAppBar.brand(showBottomBorder: true, hideAlerts: true),
        body: SafeArea(
          child: BlocBuilder<AlertsBloc, AlertsState>(
            builder: (context, state) {
              if (state is AlertsInitial || (state is AlertsLoading && state is! AlertsLoaded)) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is AlertsError) {
                return Center(child: Text('Error: ${state.message}'));
              }

              if (state is AlertsLoaded) {
                final filteredAlerts = state.alerts.where((alert) {
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

                return Column(
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
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
