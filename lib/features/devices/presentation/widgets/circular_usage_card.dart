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
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
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
                  backgroundColor: progressColor.withValues(alpha: 0.1),
                  color: progressColor,
                  strokeCap: StrokeCap.round,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
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
                color: AppColors.textMuted,
              ),
              const SizedBox(width: 4),
              Text(
                trend,
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
