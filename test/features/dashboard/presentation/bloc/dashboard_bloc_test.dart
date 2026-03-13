import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plexuspules/core/error/failures.dart';
import 'package:plexuspules/features/dashboard/domain/entities/dashboard_metrics.dart';
import 'package:plexuspules/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:plexuspules/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:plexuspules/features/dashboard/presentation/bloc/dashboard_state.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late DashboardBloc bloc;
  late MockGetDashboardMetricsUseCase mockGetDashboardMetrics;

  setUp(() {
    mockGetDashboardMetrics = MockGetDashboardMetricsUseCase();
    bloc = DashboardBloc(mockGetDashboardMetrics);
    registerTestFallbacks();
  });

  tearDown(() {
    bloc.close();
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

  test('initial state should be DashboardInitial', () {
    expect(bloc.state, const DashboardInitial());
  });

  group('FetchDashboardMetrics', () {
    blocTest<DashboardBloc, DashboardState>(
      'emits [DashboardLoading, DashboardLoaded] when data is gotten successfully',
      build: () {
        when(() => mockGetDashboardMetrics())
            .thenAnswer((_) async => const Right(tDashboardMetrics));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchDashboardMetrics()),
      expect: () => [
        const DashboardLoading(),
        const DashboardLoaded(tDashboardMetrics),
      ],
      verify: (_) {
        verify(() => mockGetDashboardMetrics()).called(1);
      },
    );

    blocTest<DashboardBloc, DashboardState>(
      'emits [DashboardLoading, DashboardError] when getting data fails',
      build: () {
        when(() => mockGetDashboardMetrics())
            .thenAnswer((_) async => const Left(ServerFailure('Server error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchDashboardMetrics()),
      expect: () => [
        const DashboardLoading(),
        const DashboardError('Server error'),
      ],
    );
  });

  group('RefreshDashboardMetrics', () {
    blocTest<DashboardBloc, DashboardState>(
      'emits [DashboardLoaded] when data is refreshed successfully',
      build: () {
        when(() => mockGetDashboardMetrics())
            .thenAnswer((_) async => const Right(tDashboardMetrics));
        return bloc;
      },
      act: (bloc) => bloc.add(const RefreshDashboardMetrics()),
      expect: () => [
        const DashboardLoaded(tDashboardMetrics),
      ],
    );
  });
}
