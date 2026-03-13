import 'package:flutter_test/flutter_test.dart';
import 'package:plexuspules/features/dashboard/data/models/dashboard_metrics_model.dart';
import 'package:plexuspules/features/dashboard/domain/entities/dashboard_metrics.dart';

void main() {
  const tDashboardMetricsModel = DashboardMetricsModel(
    totalDevices: 100,
    onlineDevices: 80,
    offlineDevices: 20,
    alerts: 5,
    cpuUsage: 45.5,
    memoryUsage: 60.2,
    networkTraffic: 125.5,
    cpuHistory: null,
    memoryHistory: null,
  );

  test('should be a subclass of DashboardMetrics entity', () async {
    expect(tDashboardMetricsModel, isA<DashboardMetrics>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is correct', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {
        'totalDevices': 100,
        'onlineDevices': 80,
        'offlineDevices': 20,
        'alerts': 5,
        'cpuUsage': 45.5,
        'memoryUsage': 60.2,
        'networkTraffic': 125.5,
      };

      // act
      final result = DashboardMetricsModel.fromJson(jsonMap);

      // assert
      expect(result, tDashboardMetricsModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // act
      final result = tDashboardMetricsModel.toJson();

      // assert
      final expectedMap = {
        'totalDevices': 100,
        'onlineDevices': 80,
        'offlineDevices': 20,
        'alerts': 5,
        'cpuUsage': 45.5,
        'memoryUsage': 60.2,
        'networkTraffic': 125.5,
        'cpuHistory': null,
        'memoryHistory': null,
      };
      expect(result, expectedMap);
    });
  });
}
