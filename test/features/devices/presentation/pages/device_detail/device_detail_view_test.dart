import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plexuspules/features/devices/domain/entities/device.dart';
import 'package:plexuspules/features/devices/presentation/bloc/device_detail_bloc.dart';
import 'package:plexuspules/features/devices/presentation/bloc/device_detail_state.dart';
import 'package:plexuspules/features/devices/presentation/pages/device_detail/device_detail_view.dart';
import 'package:plexuspules/features/devices/presentation/widgets/device_status_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../helpers/test_helpers.dart';

void main() {
  late MockDeviceDetailBloc mockDeviceDetailBloc;

  setUp(() {
    mockDeviceDetailBloc = MockDeviceDetailBloc();
    registerTestFallbacks();
  });

  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp(
        home: BlocProvider<DeviceDetailBloc>.value(
          value: mockDeviceDetailBloc,
          child: const DeviceDetailView(deviceId: '1'),
        ),
      ),
    );
  }

  final tDevice = Device(
    id: '1',
    name: 'Device 1',
    status: DeviceStatus.online,
    ipAddress: '192.168.1.1',
    location: 'Rack A',
    lastSeen: DateTime.now(),
    type: 'Router',
    cpuUsage: 45.0,
    memoryUsage: 60.0,
    performanceHistory: const [10, 20, 30],
  );

  testWidgets('should render loading indicator when status is loading', (tester) async {
    // arrange
    when(() => mockDeviceDetailBloc.state).thenReturn(
      const DeviceDetailState(status: DeviceDetailStatus.loading),
    );
    when(() => mockDeviceDetailBloc.stream).thenAnswer((_) => const Stream.empty());

    // act
    await tester.pumpWidget(createWidgetUnderTest());

    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should render device details when status is success', (tester) async {
    // arrange
    when(() => mockDeviceDetailBloc.state).thenReturn(
      DeviceDetailState(
        status: DeviceDetailStatus.success,
        device: tDevice,
      ),
    );
    when(() => mockDeviceDetailBloc.stream).thenAnswer((_) => const Stream.empty());

    // act
    await tester.pumpWidget(createWidgetUnderTest());

    // assert
    expect(find.text('Device 1'), findsOneWidget);
    expect(find.textContaining('192.168.1.1'), findsOneWidget);
    expect(find.text('Rack A'), findsOneWidget);
    expect(find.byType(DeviceStatusCard), findsOneWidget);
  });

  testWidgets('should render error message when status is error', (tester) async {
    // arrange
    when(() => mockDeviceDetailBloc.state).thenReturn(
      const DeviceDetailState(status: DeviceDetailStatus.error, message: 'Server error'),
    );
    when(() => mockDeviceDetailBloc.stream).thenAnswer((_) => const Stream.empty());

    // act
    await tester.pumpWidget(createWidgetUnderTest());

    // assert
    expect(find.text('Error: Server error'), findsOneWidget);
  });
}
