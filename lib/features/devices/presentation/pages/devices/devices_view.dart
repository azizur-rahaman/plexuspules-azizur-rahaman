import 'package:flutter/material.dart';
import 'package:plexuspules/core/constants/app_sizes.dart';
import 'package:plexuspules/config/theme/app_colors.dart';
import 'package:plexuspules/core/widgets/common_app_bar.dart';
import 'package:plexuspules/features/devices/presentation/widgets/device_card.dart';

class DevicesView extends StatefulWidget {
  const DevicesView({super.key});

  @override
  State<DevicesView> createState() => _DevicesViewState();
}

class _DevicesViewState extends State<DevicesView> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CommonAppBar.brand(),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.all(AppSizes.p20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.p12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search device or IP...',
                    hintStyle: const TextStyle(color: AppColors.textMuted),
                    prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.p12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: AppSizes.p16),
                  ),
                ),
              ),
            ),

            // Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: AppSizes.p20),
              child: Row(
                children: [
                  _FilterChip(
                    label: 'All',
                    isSelected: _selectedFilter == 'All',
                    onSelect: () => setState(() => _selectedFilter = 'All'),
                  ),
                  AppSizes.gap12,
                  _FilterChip(
                    label: 'Online',
                    isSelected: _selectedFilter == 'Online',
                    onSelect: () => setState(() => _selectedFilter = 'Online'),
                  ),
                  AppSizes.gap12,
                  _FilterChip(
                    label: 'Offline',
                    isSelected: _selectedFilter == 'Offline',
                    onSelect: () => setState(() => _selectedFilter = 'Offline'),
                  ),
                ],
              ),
            ),

            AppSizes.gap20,

            // Device List
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.p20),
                children: [
                  const DeviceCard(
                    name: 'Core-Switch-01',
                    ipAddress: '192.168.1.1',
                    location: 'Singapore Data Center',
                    status: DeviceStatus.online,
                    icon: Icons.router_outlined,
                  ),
                  AppSizes.gap16,
                  const DeviceCard(
                    name: 'Edge-Router-NY-04',
                    ipAddress: '10.0.42.15',
                    location: 'New York Node',
                    status: DeviceStatus.offline,
                    icon: Icons.settings_input_component_outlined,
                  ),
                  AppSizes.gap16,
                  const DeviceCard(
                    name: 'DB-Cluster-Primary',
                    ipAddress: '172.16.0.8',
                    location: 'London AWS-West',
                    status: DeviceStatus.online,
                    icon: Icons.storage_outlined,
                  ),
                  AppSizes.gap16,
                  const DeviceCard(
                    name: 'AP-Floor-02-North',
                    ipAddress: '192.168.10.22',
                    location: 'HQ - Tokyo',
                    status: DeviceStatus.online,
                    icon: Icons.wifi_tethering_outlined,
                  ),
                  AppSizes.gap24, // Bottom padding
                ],
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
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.cardBorder,
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
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
