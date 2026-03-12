import 'package:flutter/material.dart';
import 'package:plexuspules/core/constants/app_sizes.dart';
import 'package:plexuspules/config/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

enum DeviceStatus { online, offline }

class DeviceCard extends StatelessWidget {
  final String name;
  final String ipAddress;
  final String location;
  final DeviceStatus status;
  final IconData icon;

  const DeviceCard({
    super.key,
    required this.name,
    required this.ipAddress,
    required this.location,
    required this.status,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isOnline = status == DeviceStatus.online;

    return GestureDetector(
      onTap: () => context.push('/device-detail/$name'),
      child: Container(
        padding: EdgeInsets.all(AppSizes.p16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppSizes.p16),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Device Icon Container
          Container(
            padding: EdgeInsets.all(AppSizes.p12),
            decoration: BoxDecoration(
              color: AppColors.background.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppSizes.p12),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: AppSizes.p24,
            ),
          ),
          AppSizes.gap16,
          // Device Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                    ),
                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: (isOnline ? AppColors.healthy : AppColors.critical)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: isOnline ? AppColors.healthy : AppColors.critical,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isOnline ? 'ONLINE' : 'OFFLINE',
                            style: TextStyle(
                              color: isOnline ? AppColors.healthy : AppColors.critical,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  ipAddress,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}
