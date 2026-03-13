import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plexuspules/features/devices/domain/entities/device.dart';
import 'package:plexuspules/features/devices/domain/usecases/get_devices.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late GetDevices useCase;
  late MockDevicesRepository mockDevicesRepository;

  setUp(() {
    mockDevicesRepository = MockDevicesRepository();
    useCase = GetDevices(mockDevicesRepository);
    registerTestFallbacks();
  });

  final tDevices = [
    Device(
      id: '1',
      name: 'Device 1',
      status: DeviceStatus.online,
      ipAddress: '192.168.1.1',
      location: 'Rack A',
      lastSeen: DateTime.now(),
      type: 'Router',
      cpuUsage: 10.0,
      memoryUsage: 20.0,
    ),
  ];

  const tParams = GetDevicesParams(
    search: 'Device',
    status: 'online',
    page: 1,
    limit: 10,
  );

  test('should get devices from the repository', () async {
    // arrange
    when(() => mockDevicesRepository.getDevices(
          search: any(named: 'search'),
          status: any(named: 'status'),
          page: any(named: 'page'),
          limit: any(named: 'limit'),
        )).thenAnswer((_) async => Right(tDevices));

    // act
    final result = await useCase(tParams);

    // assert
    expect(result, Right(tDevices));
    verify(() => mockDevicesRepository.getDevices(
          search: tParams.search,
          status: tParams.status,
          page: tParams.page,
          limit: tParams.limit,
        )).called(1);
    verifyNoMoreInteractions(mockDevicesRepository);
  });
}
