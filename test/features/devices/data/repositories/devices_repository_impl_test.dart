import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plexuspules/core/error/exceptions.dart';
import 'package:plexuspules/core/error/failures.dart';
import 'package:plexuspules/features/devices/data/models/device_model.dart';
import 'package:plexuspules/features/devices/data/repositories/devices_repository_impl.dart';
import 'package:plexuspules/features/devices/domain/entities/device.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late DevicesRepositoryImpl repository;
  late MockDevicesRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockDevicesRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = DevicesRepositoryImpl(mockRemoteDataSource, mockNetworkInfo);
  });

  final tDeviceModel = DeviceModel(
    id: '1',
    name: 'Device 1',
    status: DeviceStatus.online,
    ipAddress: '192.168.1.1',
    location: 'Rack A',
    lastSeen: DateTime.parse('2023-01-01T00:00:00Z'),
    type: 'Router',
    cpuUsage: 10.0,
    memoryUsage: 20.0,
  );

  final tDeviceModels = [tDeviceModel];

  group('getDevices', () {
    test('should check if the device is online', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getDevices(
            search: any(named: 'search'),
            status: any(named: 'status'),
            page: any(named: 'page'),
            limit: any(named: 'limit'),
          )).thenAnswer((_) async => tDeviceModels);

      // act
      await repository.getDevices();

      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when the call to remote data source is successful', () async {
        // arrange
        when(() => mockRemoteDataSource.getDevices(
              search: any(named: 'search'),
              status: any(named: 'status'),
              page: any(named: 'page'),
              limit: any(named: 'limit'),
            )).thenAnswer((_) async => tDeviceModels);

        // act
        final result = await repository.getDevices();

        // assert
        verify(() => mockRemoteDataSource.getDevices());
        expect(result, Right(tDeviceModels));
      });

      test('should return server failure when the call to remote data source is unsuccessful', () async {
        // arrange
        when(() => mockRemoteDataSource.getDevices(
              search: any(named: 'search'),
              status: any(named: 'status'),
              page: any(named: 'page'),
              limit: any(named: 'limit'),
            )).thenThrow(const ServerException('Server error'));

        // act
        final result = await repository.getDevices();

        // assert
        verify(() => mockRemoteDataSource.getDevices());
        expect(result, const Left(ServerFailure('Server error')));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return network failure when the device is offline', () async {
        // act
        final result = await repository.getDevices();

        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, const Left(NetworkFailure()));
      });
    });
  });

  group('getDeviceDetails', () {
    const tId = '1';

    test('should check if the device is online', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getDeviceDetails(any()))
          .thenAnswer((_) async => tDeviceModel);

      // act
      await repository.getDeviceDetails(tId);

      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when the call to remote data source is successful', () async {
        // arrange
        when(() => mockRemoteDataSource.getDeviceDetails(any()))
            .thenAnswer((_) async => tDeviceModel);

        // act
        final result = await repository.getDeviceDetails(tId);

        // assert
        verify(() => mockRemoteDataSource.getDeviceDetails(tId));
        expect(result, Right(tDeviceModel));
      });

      test('should return server failure when the call to remote data source is unsuccessful', () async {
        // arrange
        when(() => mockRemoteDataSource.getDeviceDetails(any()))
            .thenThrow(const ServerException('Server error'));

        // act
        final result = await repository.getDeviceDetails(tId);

        // assert
        verify(() => mockRemoteDataSource.getDeviceDetails(tId));
        expect(result, const Left(ServerFailure('Server error')));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return network failure when the device is offline', () async {
        // act
        final result = await repository.getDeviceDetails(tId);

        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, const Left(NetworkFailure()));
      });
    });
  });
}
