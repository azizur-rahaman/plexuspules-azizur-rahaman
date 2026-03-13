import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plexuspules/core/error/exceptions.dart';
import 'package:plexuspules/core/error/failures.dart';
import 'package:plexuspules/features/dashboard/data/models/dashboard_metrics_model.dart';
import 'package:plexuspules/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late DashboardRepositoryImpl repository;
  late MockDashboardRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockDashboardRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = DashboardRepositoryImpl(mockRemoteDataSource, mockNetworkInfo);
  });

  const tDashboardMetricsModel = DashboardMetricsModel(
    totalDevices: 100,
    onlineDevices: 80,
    offlineDevices: 20,
    alerts: 5,
    cpuUsage: 45.5,
    memoryUsage: 60.2,
    networkTraffic: 125.5,
  );

  group('getDashboardMetrics', () {
    test('should check if the device is online', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getDashboardMetrics())
          .thenAnswer((_) async => tDashboardMetricsModel);

      // act
      await repository.getDashboardMetrics();

      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when the call to remote data source is successful', () async {
        // arrange
        when(() => mockRemoteDataSource.getDashboardMetrics())
            .thenAnswer((_) async => tDashboardMetricsModel);

        // act
        final result = await repository.getDashboardMetrics();

        // assert
        verify(() => mockRemoteDataSource.getDashboardMetrics());
        expect(result, const Right(tDashboardMetricsModel));
      });

      test('should return server failure when the call to remote data source is unsuccessful', () async {
        // arrange
        when(() => mockRemoteDataSource.getDashboardMetrics())
            .thenThrow(const ServerException('Server error'));

        // act
        final result = await repository.getDashboardMetrics();

        // assert
        verify(() => mockRemoteDataSource.getDashboardMetrics());
        expect(result, const Left(ServerFailure('Server error')));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return network failure when the device is offline', () async {
        // act
        final result = await repository.getDashboardMetrics();

        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, const Left(NetworkFailure()));
      });
    });
  });
}
