import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plexuspules/core/error/failures.dart';
import 'package:plexuspules/features/devices/domain/entities/device.dart';
import 'package:plexuspules/features/devices/presentation/bloc/device_detail_bloc.dart';
import 'package:plexuspules/features/devices/presentation/bloc/device_detail_event.dart';
import 'package:plexuspules/features/devices/presentation/bloc/device_detail_state.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late DeviceDetailBloc bloc;
  late MockGetDeviceDetailsUseCase mockGetDeviceDetails;

  setUp(() {
    mockGetDeviceDetails = MockGetDeviceDetailsUseCase();
    bloc = DeviceDetailBloc(mockGetDeviceDetails);
    registerTestFallbacks();
  });

  tearDown(() {
    bloc.close();
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
  );

  test('initial state should be initial state with default values', () {
    expect(bloc.state, const DeviceDetailState());
  });

  group('FetchDeviceDetail', () {
    blocTest<DeviceDetailBloc, DeviceDetailState>(
      'emits [loading, success] when data is gotten successfully',
      build: () {
        when(() => mockGetDeviceDetails(any()))
            .thenAnswer((_) async => Right(tDevice));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchDeviceDetail(tId)),
      expect: () => [
        const DeviceDetailState(status: DeviceDetailStatus.loading),
        DeviceDetailState(
          status: DeviceDetailStatus.success,
          device: tDevice,
        ),
      ],
    );

    blocTest<DeviceDetailBloc, DeviceDetailState>(
      'emits [loading, error] when getting data fails',
      build: () {
        when(() => mockGetDeviceDetails(any()))
            .thenAnswer((_) async => const Left(ServerFailure('Server error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchDeviceDetail(tId)),
      expect: () => [
        const DeviceDetailState(status: DeviceDetailStatus.loading),
        const DeviceDetailState(status: DeviceDetailStatus.error, message: 'Server error'),
      ],
    );
  });
}
