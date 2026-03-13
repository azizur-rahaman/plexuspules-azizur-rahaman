import 'package:flutter_test/flutter_test.dart';
import 'package:plexuspules/features/devices/data/models/device_model.dart';
import 'package:plexuspules/features/devices/domain/entities/device.dart';

void main() {
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
    performanceHistory: const [10.0, 15.0, 20.0],
  );

  test('should be a subclass of Device entity', () async {
    expect(tDeviceModel, isA<Device>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is correct', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {
        'id': '1',
        'name': 'Device 1',
        'status': 'online',
        'ipAddress': '192.168.1.1',
        'location': 'Rack A',
        'lastPing': '2023-01-01T00:00:00.000Z',
        'type': 'Router',
        'cpuUsage': 10.0,
        'memoryUsage': 20.0,
        'performanceHistory': [10.0, 15.0, 20.0],
      };

      // act
      final result = DeviceModel.fromJson(jsonMap);

      // assert
      expect(result, tDeviceModel);
    });
   group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // act
      final result = tDeviceModel.toJson();

      // assert
      final expectedMap = {
        'id': '1',
        'name': 'Device 1',
        'status': 'online',
        'ipAddress': '192.168.1.1',
        'location': 'Rack A',
        'lastPing': '2023-01-01T00:00:00.000Z',
        'type': 'Router',
        'cpuUsage': 10.0,
        'memoryUsage': 20.0,
        'performanceHistory': [10.0, 15.0, 20.0],
      };
      expect(result, expectedMap);
    });
  });
});
}
