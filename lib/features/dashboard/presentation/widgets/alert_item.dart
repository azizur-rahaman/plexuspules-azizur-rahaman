import 'package:flutter/material.dart';
import 'package:plexuspules/core/constants/app_sizes.dart';

enum AlertType { critical, warning, info }

class AlertItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final AlertType type;

  const AlertItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.type,
    super.key,
  });

  Color _getColor() {
    switch (type) {
      case AlertType.critical:
        return Colors.red;
      case AlertType.warning:
        return Colors.orange;
      case AlertType.info:
        return Colors.blue;
    }
  }

  String _getTypeLabel() {
    switch (type) {
      case AlertType.critical:
        return 'CRITICAL';
      case AlertType.warning:
        return 'WARNING';
      case AlertType.info:
        return 'INFO';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    return Container(
      padding: EdgeInsets.all(AppSizes.p16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppSizes.p8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              type == AlertType.critical
                  ? Icons.error_outline
                  : type == AlertType.warning
                      ? Icons.warning_amber_outlined
                      : Icons.info_outline,
              color: color,
              size: AppSizes.iconMedium,
            ),
          ),
          AppSizes.gap16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: AppSizes.font10,
                    ),
              ),
              AppSizes.gap4,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: color.withValues(alpha: 0.3)),
                ),
                child: Text(
                  _getTypeLabel(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 8,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
