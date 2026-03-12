import 'package:flutter/material.dart';
import 'package:plexuspules/config/theme/app_colors.dart';
import 'package:plexuspules/core/constants/app_sizes.dart';
import 'package:plexuspules/features/devices/presentation/widgets/device_card.dart';

class DeviceStatusCard extends StatelessWidget {
  final String name;
  final String ipAddress;
  final String location;
  final String lastPing;
  final DeviceStatus status;
  final IconData icon;

  const DeviceStatusCard({
    super.key,
    required this.name,
    required this.ipAddress,
    required this.location,
    required this.lastPing,
    required this.status,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isOnline = status == DeviceStatus.online;

    return Container(
      padding: EdgeInsets.all(AppSizes.p20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppSizes.p12),
                decoration: BoxDecoration(
                  color: AppColors.background.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: AppSizes.p24,
                ),
              ),
              AppSizes.gap16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                    ),
                    Text(
                      'IP: $ipAddress',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              _StatusBadge(isOnline: isOnline),
            ],
          ),
          AppSizes.gap20,
          const Divider(color: AppColors.divider),
          AppSizes.gap20,
          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  label: 'LOCATION',
                  value: location,
                  icon: Icons.location_on_outlined,
                ),
              ),
              Expanded(
                child: _InfoTile(
                  label: 'LAST PING',
                  value: lastPing,
                  icon: Icons.access_time_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isOnline;

  const _StatusBadge({required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (isOnline ? AppColors.healthy : AppColors.critical)
            .withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isOnline ? AppColors.healthy : AppColors.critical,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            isOnline ? 'Online' : 'Offline',
            style: TextStyle(
              color: isOnline ? AppColors.healthy : AppColors.critical,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(icon, size: 16, color: AppColors.primary),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
