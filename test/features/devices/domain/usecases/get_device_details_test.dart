import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plexuspules/features/devices/domain/entities/device.dart';
import 'package:plexuspules/features/devices/domain/usecases/get_device_details.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late GetDeviceDetails useCase;
  late MockDevicesRepository mockDevicesRepository;

  setUp(() {
    mockDevicesRepository = MockDevicesRepository();
    useCase = GetDeviceDetails(mockDevicesRepository);
    registerTestFallbacks();
  });

  const tId = '1';
  final tDevice = Device(
    id: tId,
    name: 'Device 1',
    status: DeviceStatus.online,
    ipAddress: '192.168.1.1',
    location: 'Rack A',
    lastSeen: DateTime.now(),
    type: 'Router',
    cpuUsage: 10.0,
    memoryUsage: 20.0,
  );

  test('should get device details from the repository', () async {
    // arrange
    when(() => mockDevicesRepository.getDeviceDetails(any()))
        .thenAnswer((_) async => Right(tDevice));

    // act
    final result = await useCase(tId);

    // assert
    expect(result, Right(tDevice));
    verify(() => mockDevicesRepository.getDeviceDetails(tId)).called(1);
    verifyNoMoreInteractions(mockDevicesRepository);
  });
}
