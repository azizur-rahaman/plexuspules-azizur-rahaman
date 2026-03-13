import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:plexuspules/core/widgets/common_app_bar.dart';

class PerformanceView extends StatelessWidget {
  const PerformanceView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CommonAppBar.brand(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Performance Analytics',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: const Color(0xFF2F6B4F),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Real-time system health monitoring',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 32),
              _buildChartCard(
                title: 'CPU USAGE',
                value: '42.8%',
                change: '-2.4%',
                isPositive: false,
                chartColor: const Color(0xFF3B82F6),
                spots: [
                  const FlSpot(0, 20),
                  const FlSpot(2, 25),
                  const FlSpot(4, 15),
                  const FlSpot(6, 45),
                  const FlSpot(8, 38),
                  const FlSpot(10, 58),
                  const FlSpot(12, 52),
                  const FlSpot(14, 70),
                  const FlSpot(16, 62),
                  const FlSpot(18, 85),
                  const FlSpot(20, 75),
                ],
                maxY: 100,
                yInterval: 50,
              ),
              const SizedBox(height: 24),
              _buildChartCard(
                title: 'MEMORY USAGE',
                value: '6.4 GB',
                change: '+0.8%',
                isPositive: true,
                chartColor: const Color(0xFF10B981),
                spots: [
                  const FlSpot(0, 4),
                  const FlSpot(2, 5),
                  const FlSpot(4, 6),
                  const FlSpot(6, 4.5),
                  const FlSpot(8, 7),
                  const FlSpot(10, 8),
                  const FlSpot(12, 9),
                  const FlSpot(14, 8.5),
                  const FlSpot(16, 9.5),
                  const FlSpot(18, 10),
                  const FlSpot(20, 10.5),
                ],
                maxY: 16,
                yInterval: 8,
                yLabel: (val) => '${val.toInt()}GB',
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      title: 'UPTIME',
                      value: '99.98%',
                      valueColor: const Color(0xFF2F6B4F),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'LATENCY',
                      value: '24ms',
                      valueColor: const Color(0xFF2F6B4F),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartCard({
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
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 160,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: yInterval,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xFF94A3B8).withValues(alpha: 0.2),
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
                      interval: 6,
                      getTitlesWidget: (value, meta) {
                        String text = '';
                        switch (value.toInt()) {
                          case 0:
                            text = '00:00';
                            break;
                          case 6:
                            text = '06:00';
                            break;
                          case 12:
                            text = '12:00';
                            break;
                          case 18:
                            text = '18:00';
                            break;
                          case 20:
                            text = 'Now';
                            break;
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            text,
                            style: const TextStyle(
                              color: Color(0xFF94A3B8),
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
                          style: const TextStyle(
                            color: Color(0xFF94A3B8),
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
                maxX: 20,
                minY: 0,
                maxY: maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: chartColor,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          chartColor.withValues(alpha: 0.2),
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

  Widget _buildMetricCard({
    required String title,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
