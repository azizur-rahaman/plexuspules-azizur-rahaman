import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plexuspules/core/constants/app_sizes.dart';
import 'package:plexuspules/config/theme/app_colors.dart';
import 'package:plexuspules/core/widgets/common_app_bar.dart';
import 'package:plexuspules/features/devices/presentation/widgets/device_card.dart';
import 'package:plexuspules/core/widgets/common_search_bar.dart';
import 'package:plexuspules/features/monitoring/domain/entities/device.dart';
import '../../bloc/devices_bloc.dart';
import '../../bloc/devices_event.dart';
import '../../bloc/devices_state.dart';

class DevicesView extends StatefulWidget {
  const DevicesView({super.key});

  @override
  State<DevicesView> createState() => _DevicesViewState();
}

class _DevicesViewState extends State<DevicesView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<DevicesBloc>().add(const LoadMoreDevices());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CommonAppBar.brand(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.all(AppSizes.p20),
              child: BlocBuilder<DevicesBloc, DevicesState>(
                buildWhen: (previous, current) => previous.searchQuery != current.searchQuery,
                builder: (context, state) {
                  return CommonSearchBar(
                    hintText: 'Search device or IP...',
                    onChanged: (value) {
                      context.read<DevicesBloc>().add(SearchChanged(value));
                    },
                  );
                },
              ),
            ),

            // Filters
            BlocBuilder<DevicesBloc, DevicesState>(
              buildWhen: (previous, current) => previous.statusFilter != current.statusFilter,
              builder: (context, state) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.p20),
                  child: Row(
                    children: [
                      _FilterChip(
                        label: 'All',
                        isSelected: state.statusFilter == null,
                        onSelect: () => context.read<DevicesBloc>().add(const ChangeFilter(null)),
                      ),
                      AppSizes.gap12,
                      _FilterChip(
                        label: 'Online',
                        isSelected: state.statusFilter == DeviceStatus.online,
                        onSelect: () => context.read<DevicesBloc>().add(const ChangeFilter(DeviceStatus.online)),
                      ),
                      AppSizes.gap12,
                      _FilterChip(
                        label: 'Offline',
                        isSelected: state.statusFilter == DeviceStatus.offline,
                        onSelect: () => context.read<DevicesBloc>().add(const ChangeFilter(DeviceStatus.offline)),
                      ),
                      AppSizes.gap12,
                      _FilterChip(
                        label: 'Service',
                        isSelected: state.statusFilter == DeviceStatus.maintenance,
                        onSelect: () => context.read<DevicesBloc>().add(const ChangeFilter(DeviceStatus.maintenance)),
                      ),
                    ],
                  ),
                );
              },
            ),

            AppSizes.gap20,

            // Device List
            Expanded(
              child: BlocBuilder<DevicesBloc, DevicesState>(
                builder: (context, state) {
                  switch (state.status) {
                    case DevicesStatus.initial:
                    case DevicesStatus.loading:
                      if (state.devices.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                    case DevicesStatus.error:
                      if (state.devices.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Error: ${state.message}'),
                              AppSizes.gap16,
                              ElevatedButton(
                                onPressed: () => context.read<DevicesBloc>().add(const FetchDevices()),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }
                    case DevicesStatus.success:
                      if (state.devices.isEmpty) {
                        return const Center(child: Text('No devices found'));
                      }
                  }

                  return ListView.separated(
                    controller: _scrollController,
                    padding: EdgeInsets.fromLTRB(
                      AppSizes.p20,
                      0,
                      AppSizes.p20,
                      AppSizes.p40,
                    ),
                    itemCount: state.hasReachedMax ? state.devices.length : state.devices.length + 1,
                    separatorBuilder: (context, index) => AppSizes.gap16,
                    itemBuilder: (context, index) {
                      if (index < state.devices.length) {
                        final device = state.devices[index];
                        return DeviceCard(
                          name: device.name,
                          ipAddress: device.ipAddress,
                          location: device.location,
                          status: device.status,
                          icon: device.status == DeviceStatus.online 
                            ? Icons.router_outlined 
                            : Icons.storage_outlined,
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 32),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
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

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelect;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : (theme.brightness == Brightness.light
                  ? Colors.white
                  : theme.colorScheme.surface),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (theme.brightness == Brightness.light
                    ? AppColors.cardBorder
                    : theme.colorScheme.outlineVariant),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : (theme.brightness == Brightness.light
                    ? AppColors.textSecondary
                    : theme.colorScheme.onSurfaceVariant),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
