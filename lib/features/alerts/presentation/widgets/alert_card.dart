import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../config/theme/app_colors.dart';
import '../../domain/entities/alert.dart';

class AlertCard extends StatelessWidget {
  final Alert alert;
  final VoidCallback? onAcknowledge;
  final VoidCallback? onViewDetails;

  const AlertCard({
    required this.alert,
    this.onAcknowledge,
    this.onViewDetails,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.p16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        border: Border.all(color: AppColors.cardBorder.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      alert.severity.icon,
                      color: alert.severity.color,
                      size: AppSizes.iconMedium,
                    ),
                    AppSizes.gap8,
                    Text(
                      alert.severity.label,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: alert.severity.color,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                    ),
                  ],
                ),
                Text(
                  alert.timeAgo,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textMuted,
                      ),
                ),
              ],
            ),
            AppSizes.gap12,
            Text(
              alert.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.font18,
                  ),
            ),
            AppSizes.gap4,
            Text(
              alert.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            AppSizes.gap16,
            Row(
              children: [
                _buildButton(
                  context,
                  label: 'Acknowledge',
                  onPressed: onAcknowledge,
                ),
                AppSizes.gap12,
                _buildButton(
                  context,
                  label: 'View Details',
                  isPrimary: true,
                  onPressed: onViewDetails,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String label,
    bool isPrimary = false,
    VoidCallback? onPressed,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppSizes.p12),
          decoration: BoxDecoration(
            color: isPrimary
                ? const Color(0xFFE8F3ED)
                : const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: isPrimary ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: AppSizes.font12,
                ),
              ),
              if (isPrimary) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.chevron_right,
                  size: 14,
                  color: AppColors.primary,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
