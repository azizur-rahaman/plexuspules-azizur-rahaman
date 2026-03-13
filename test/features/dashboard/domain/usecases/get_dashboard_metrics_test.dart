import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plexuspules/features/dashboard/domain/entities/dashboard_metrics.dart';
import 'package:plexuspules/features/dashboard/domain/usecases/get_dashboard_metrics.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late GetDashboardMetrics useCase;
  late MockDashboardRepository mockDashboardRepository;

  setUp(() {
    mockDashboardRepository = MockDashboardRepository();
    useCase = GetDashboardMetrics(mockDashboardRepository);
  });

  const tDashboardMetrics = DashboardMetrics(
    totalDevices: 100,
    onlineDevices: 80,
    offlineDevices: 20,
    alerts: 5,
    cpuUsage: 45.5,
    memoryUsage: 60.2,
    networkTraffic: 125.5,
  );

  test('should get dashboard metrics from the repository', () async {
    // arrange
    when(() => mockDashboardRepository.getDashboardMetrics())
        .thenAnswer((_) async => const Right(tDashboardMetrics));

    // act
    final result = await useCase();

    // assert
    expect(result, const Right(tDashboardMetrics));
    verify(() => mockDashboardRepository.getDashboardMetrics());
    verifyNoMoreInteractions(mockDashboardRepository);
  });
}
