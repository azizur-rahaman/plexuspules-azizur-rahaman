import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plexuspules/core/error/exceptions.dart';
import 'package:plexuspules/features/devices/data/datasources/devices_remote_data_source.dart';
import 'package:plexuspules/features/devices/data/models/device_model.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late DevicesRemoteDataSourceImpl dataSource;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    dataSource = DevicesRemoteDataSourceImpl(mockDioClient);
    registerTestFallbacks();
  });

  const tId = '1';

  final tDeviceModelJson = {
    'id': '1',
    'name': 'Device 1',
    'status': 'online',
    'ipAddress': '192.168.1.1',
    'location': 'Rack A',
    'lastPing': '2023-01-01T00:00:00Z',
    'type': 'Router',
    'cpuUsage': 10.0,
    'memoryUsage': 20.0,
  };

  final tDeviceModelsJson = [tDeviceModelJson];

  group('getDevices', () {
    test('should perform a GET request on /devices URL', () async {
      // arrange
      when(() => mockDioClient.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
                data: tDeviceModelsJson,
                statusCode: 200,
                requestOptions: RequestOptions(path: '/devices'),
              ));

      // act
      await dataSource.getDevices();

      // assert
      verify(() => mockDioClient.get('/devices', queryParameters: any(named: 'queryParameters')));
    });

    test('should return List<DeviceModel> when the response code is 200', () async {
      // arrange
      when(() => mockDioClient.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
                data: tDeviceModelsJson,
                statusCode: 200,
                requestOptions: RequestOptions(path: '/devices'),
              ));

      // act
      final result = await dataSource.getDevices();

      // assert
      expect(result, isA<List<DeviceModel>>());
      expect(result.length, 1);
      expect(result.first.id, tId);
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(() => mockDioClient.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/devices'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/devices'),
          statusCode: 404,
        ),
      ));

      // act
      final call = dataSource.getDevices;

      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });

  group('getDeviceDetails', () {
    test('should perform a GET request on /devices/:id URL', () async {
      // arrange
      when(() => mockDioClient.get(any()))
          .thenAnswer((_) async => Response(
                data: tDeviceModelJson,
                statusCode: 200,
                requestOptions: RequestOptions(path: '/devices/$tId'),
              ));

      // act
      await dataSource.getDeviceDetails(tId);

      // assert
      verify(() => mockDioClient.get('/devices/$tId'));
    });

    test('should return DeviceModel when the response code is 200', () async {
      // arrange
      when(() => mockDioClient.get(any()))
          .thenAnswer((_) async => Response(
                data: tDeviceModelJson,
                statusCode: 200,
                requestOptions: RequestOptions(path: '/devices/$tId'),
              ));

      // act
      final result = await dataSource.getDeviceDetails(tId);

      // assert
      expect(result, isA<DeviceModel>());
      expect(result.id, tId);
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(() => mockDioClient.get(any()))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/devices/$tId'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/devices/$tId'),
          statusCode: 404,
        ),
      ));

      // act
      final call = dataSource.getDeviceDetails;

      // assert
      expect(() => call(tId), throwsA(isA<ServerException>()));
    });
  });
}
