import 'package:flutter/material.dart';
import 'package:plexuspules/core/constants/app_sizes.dart';
import 'package:plexuspules/config/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:plexuspules/features/monitoring/domain/entities/device.dart';

class DeviceCard extends StatelessWidget {
  final String id;
  final String name;
  final String ipAddress;
  final String location;
  final DeviceStatus status;
  final IconData icon;

  const DeviceCard({
    super.key,
    required this.id,
    required this.name,
    required this.ipAddress,
    required this.location,
    required this.status,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    BuildContext localContext = context;
    final theme = Theme.of(context);

    Color statusColor;
    String statusLabel;

    switch (status) {
      case DeviceStatus.online:
        statusColor = AppColors.healthy;
        statusLabel = 'ONLINE';
      case DeviceStatus.offline:
        statusColor = AppColors.critical;
        statusLabel = 'OFFLINE';
      case DeviceStatus.maintenance:
        statusColor = Colors.orange;
        statusLabel = 'SERVICE';
    }

    return GestureDetector(
      onTap: () => localContext.push('/device-detail/$id'),
      child: Container(
        padding: EdgeInsets.all(AppSizes.p16),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppSizes.p16),
          border: Border.all(
            color: theme.brightness == Brightness.light
                ? AppColors.cardBorder
                : AppColors.cardBorderDark,
          ),
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
                color: theme.brightness == Brightness.light
                    ? AppColors.background.withValues(alpha: 0.5)
                    : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppSizes.p12),
              ),
              child: Icon(
                icon,
                color: theme.colorScheme.primary,
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
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Status Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              statusLabel,
                              style: TextStyle(
                                color: statusColor,
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
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: theme.textTheme.bodySmall,
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
