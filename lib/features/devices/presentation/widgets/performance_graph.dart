import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plexuspules/config/theme/app_colors.dart';
import 'package:plexuspules/core/constants/app_sizes.dart';

class PerformanceGraph extends StatelessWidget {
  final List<double>? history;
  final String title;

  const PerformanceGraph({
    super.key,
    this.history,
    this.title = 'Performance',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = history ?? [0.3, 0.5, 0.4, 0.2, 0.6, 0.7, 0.8, 0.4, 0.5, 0.3, 0.8, 0.5];

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.light
                      ? AppColors.background
                      : theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                ),
                child: Text(
                  'Last 60m',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          AppSizes.gap32,
          SizedBox(
            height: 160.h,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100, // Assuming percentage
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => theme.colorScheme.primaryContainer,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${rod.toY.round()}%',
                        TextStyle(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: const FlTitlesData(show: false),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: data.asMap().entries.map((e) {
                  return _makeGroupData(context, e.key, e.value);
                }).toList(),
              ),
            ),
          ),
          AppSizes.gap16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '60M AGO',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'NOW',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  BarChartGroupData _makeGroupData(BuildContext context, int x, double y) {
    final theme = Theme.of(context);
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: (y > 70)
              ? theme.colorScheme.primary
              : theme.colorScheme.primary.withValues(alpha: 0.3),
          width: 8,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 100,
            color: theme.brightness == Brightness.light
                ? AppColors.background
                : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
