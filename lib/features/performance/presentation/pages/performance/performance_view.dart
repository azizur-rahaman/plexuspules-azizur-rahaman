import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plexuspules/core/widgets/common_app_bar.dart';
import 'package:plexuspules/features/performance/presentation/bloc/performance_bloc.dart';
import 'package:plexuspules/features/performance/presentation/bloc/performance_event.dart';
import 'package:plexuspules/features/performance/presentation/bloc/performance_state.dart';
import 'package:plexuspules/core/di/injection.dart';

class PerformanceView extends StatelessWidget {
  const PerformanceView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => getIt<PerformanceBloc>()..add(FetchPerformanceMetrics()),
      child: Scaffold(
        appBar: CommonAppBar.brand(),
        body: SafeArea(
          child: BlocBuilder<PerformanceBloc, PerformanceState>(
            builder: (context, state) {
              if (state is PerformanceInitial || (state is PerformanceLoading && state is! PerformanceLoaded)) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is PerformanceError) {
                return Center(child: Text('Error: ${state.message}'));
              }

              if (state is PerformanceLoaded) {
                final metrics = state.metrics;
                final cpuHistory = metrics.cpuHistory ?? [];
                final memoryHistory = metrics.memoryHistory ?? [];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Performance Analytics',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Real-time system health monitoring',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildChartCard(
                        context: context,
                        title: 'CPU USAGE',
                        value: metrics.cpuUsage != null ? '${metrics.cpuUsage!.toStringAsFixed(1)}%' : '—',
                        change: 'Average CPU',
                        isPositive: (metrics.cpuUsage ?? 0) < 80,
                        chartColor: Colors.blue,
                        spots: cpuHistory.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
                        maxY: 100,
                        yInterval: 25,
                      ),
                      const SizedBox(height: 24),
                      _buildChartCard(
                        context: context,
                        title: 'MEMORY USAGE',
                        value: metrics.memoryUsage != null ? '${metrics.memoryUsage!.toStringAsFixed(1)}%' : '—',
                        change: 'Average Memory',
                        isPositive: (metrics.memoryUsage ?? 0) < 80,
                        chartColor: Colors.purple,
                        spots: memoryHistory.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
                        maxY: 100,
                        yInterval: 25,
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildChartCard({
    required BuildContext context,
    required String title,
    required String value,
    required String change,
    required bool isPositive,
    required Color chartColor,
    required List<FlSpot> spots,
    required double maxY,
    required double yInterval,
    String Function(double)? yLabel,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: theme.brightness == Brightness.dark
            ? Border.all(color: theme.colorScheme.outlineVariant)
            : null,
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
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isPositive
                      ? const Color(0xFF10B981).withValues(alpha: 0.1)
                      : const Color(0xFF3B82F6).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    color: isPositive
                        ? const Color(0xFF10B981)
                        : const Color(0xFF3B82F6),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 240, // Increased height for a more prominent graph
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: yInterval,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: spots.isNotEmpty ? (spots.length / 4).ceilToDouble() : 1,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${value.toInt()}m',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                              fontSize: 10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: yInterval,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          yLabel?.call(value) ?? '${value.toInt()}%',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                            fontSize: 10,
                          ),
                        );
                      },
                      reservedSize: 35,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: spots.isNotEmpty ? (spots.length - 1).toDouble() : 10,
                minY: 0,
                maxY: maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots.isEmpty ? [const FlSpot(0, 0)] : spots,
                    isCurved: true,
                    color: chartColor,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          chartColor.withValues(alpha: 0.3),
                          chartColor.withValues(alpha: 0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
