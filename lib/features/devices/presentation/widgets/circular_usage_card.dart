import 'package:flutter/material.dart';
import 'package:plexuspules/config/theme/app_colors.dart';
import 'package:plexuspules/core/constants/app_sizes.dart';

class CircularUsageCard extends StatelessWidget {
  final String title;
  final double progress;
  final String trend;
  final Color progressColor;
  final bool isTrendPositive;

  const CircularUsageCard({
    super.key,
    required this.title,
    required this.progress,
    required this.trend,
    required this.progressColor,
    this.isTrendPositive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(AppSizes.p20),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
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
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ),
          AppSizes.gap20,
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 10,
                  backgroundColor: progressColor.withValues(alpha: 0.15),
                  color: progressColor,
                  strokeCap: StrokeCap.round,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          AppSizes.gap20,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isTrendPositive ? Icons.trending_up : Icons.trending_down,
                size: 14,
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 4),
              Text(
                trend,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
