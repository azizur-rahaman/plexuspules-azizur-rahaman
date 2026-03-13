import 'package:flutter/material.dart';
import 'package:plexuspules/core/constants/app_sizes.dart';

class NetworkHealthCard extends StatelessWidget {
  final int percentage;
  final String latency;
  final String status;

  const NetworkHealthCard({
    required this.percentage,
    required this.latency,
    required this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.p20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.timeline, color: Colors.green, size: AppSizes.iconMedium),
                  AppSizes.gap12,
                  Text(
                    'Network Health',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Text(
                '$percentage%',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
              ),
            ],
          ),
          AppSizes.gap16,
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 8,
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade200
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
          AppSizes.gap24,
          Row(
            children: [
              _buildMetric(context, Icons.circle, '$status Latency ($latency)', Colors.green),
              const Spacer(),
              _buildMetric(context, Icons.circle, 'No Packet Loss', Colors.green.shade200),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(BuildContext context, IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, size: 8, color: color),
        AppSizes.gap8,
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}
