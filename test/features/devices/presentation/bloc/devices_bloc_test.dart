import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plexuspules/core/error/failures.dart';
import 'package:plexuspules/features/devices/domain/entities/device.dart';
import 'package:plexuspules/features/devices/presentation/bloc/devices_bloc.dart';
import 'package:plexuspules/features/devices/presentation/bloc/devices_event.dart';
import 'package:plexuspules/features/devices/presentation/bloc/devices_state.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late DevicesBloc bloc;
  late MockGetDevicesUseCase mockGetDevices;

  setUp(() {
    mockGetDevices = MockGetDevicesUseCase();
    bloc = DevicesBloc(mockGetDevices);
    registerTestFallbacks();
  });

  tearDown(() {
    bloc.close();
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
    ),
  ];

  test('initial state should be initial state with default values', () {
    expect(bloc.state, const DevicesState());
  });

  group('FetchDevices', () {
    blocTest<DevicesBloc, DevicesState>(
      'emits [loading, success] when data is gotten successfully',
      build: () {
        when(() => mockGetDevices(any()))
            .thenAnswer((_) async => Right(tDevices));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchDevices()),
      expect: () => [
        const DevicesState(status: DevicesStatus.loading),
        DevicesState(
          status: DevicesStatus.success,
          devices: tDevices,
          hasReachedMax: true, // devices.length (1) < _pageSize (10)
        ),
      ],
    );

    blocTest<DevicesBloc, DevicesState>(
      'emits [loading, error] when getting data fails',
      build: () {
        when(() => mockGetDevices(any()))
            .thenAnswer((_) async => const Left(ServerFailure('Server error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchDevices()),
      expect: () => [
        const DevicesState(status: DevicesStatus.loading),
        const DevicesState(status: DevicesStatus.error, message: 'Server error'),
      ],
    );
  });

  group('SearchChanged', () {
    blocTest<DevicesBloc, DevicesState>(
      'emits [loading, success] with new search query',
      build: () {
        when(() => mockGetDevices(any()))
            .thenAnswer((_) async => Right(tDevices));
        return bloc;
      },
      act: (bloc) => bloc.add(const SearchChanged('new search')),
      wait: const Duration(milliseconds: 300),
      expect: () => [
        const DevicesState(
          status: DevicesStatus.loading,
          searchQuery: 'new search',
        ),
        DevicesState(
          status: DevicesStatus.success,
          devices: tDevices,
          searchQuery: 'new search',
          hasReachedMax: true,
        ),
      ],
    );
  });

  group('ChangeFilter', () {
    blocTest<DevicesBloc, DevicesState>(
      'emits [loading, success] with new status filter',
      build: () {
        when(() => mockGetDevices(any()))
            .thenAnswer((_) async => Right(tDevices));
        return bloc;
      },
      act: (bloc) => bloc.add(const ChangeFilter(DeviceStatus.online)),
      expect: () => [
        const DevicesState(
          status: DevicesStatus.loading,
          statusFilter: DeviceStatus.online,
        ),
        DevicesState(
          status: DevicesStatus.success,
          devices: tDevices,
          statusFilter: DeviceStatus.online,
          hasReachedMax: true,
        ),
      ],
    );
  });
}
