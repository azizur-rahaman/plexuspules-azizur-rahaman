import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plexuspules/features/devices/domain/entities/device.dart';
import 'package:plexuspules/features/devices/presentation/bloc/devices_bloc.dart';
import 'package:plexuspules/features/devices/presentation/bloc/devices_state.dart';
import 'package:plexuspules/features/devices/presentation/pages/devices/devices_view.dart';
import 'package:plexuspules/features/devices/presentation/widgets/device_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../helpers/test_helpers.dart';

void main() {
  late MockDevicesBloc mockDevicesBloc;

  setUp(() {
    mockDevicesBloc = MockDevicesBloc();
    registerTestFallbacks();
  });

  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(393, 852), // Default design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp(
        home: BlocProvider<DevicesBloc>.value(
          value: mockDevicesBloc,
          child: const DevicesView(),
        ),
      ),
    );
  }

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

  testWidgets('should render search bar and filter chips', (tester) async {
    // arrange
    when(() => mockDevicesBloc.state).thenReturn(const DevicesState());
    when(() => mockDevicesBloc.stream).thenAnswer((_) => const Stream.empty());

    // act
    await tester.pumpWidget(createWidgetUnderTest());

    // assert
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Online'), findsOneWidget);
    expect(find.text('Offline'), findsOneWidget);
  });

  testWidgets('should render loading indicator when status is loading and no devices', (tester) async {
    // arrange
    when(() => mockDevicesBloc.state).thenReturn(
      const DevicesState(status: DevicesStatus.loading),
    );
    when(() => mockDevicesBloc.stream).thenAnswer((_) => const Stream.empty());

    // act
    await tester.pumpWidget(createWidgetUnderTest());

    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should render list of devices when status is success', (tester) async {
    // arrange
    when(() => mockDevicesBloc.state).thenReturn(
      DevicesState(
        status: DevicesStatus.success,
        devices: tDevices,
        hasReachedMax: true,
      ),
    );
    when(() => mockDevicesBloc.stream).thenAnswer((_) => const Stream.empty());

    // act
    await tester.pumpWidget(createWidgetUnderTest());

    // assert
    expect(find.byType(DeviceCard), findsOneWidget);
    expect(find.text('Device 1'), findsOneWidget);
    expect(find.text('192.168.1.1'), findsOneWidget);
  });

  testWidgets('should render error message when status is error', (tester) async {
    // arrange
    when(() => mockDevicesBloc.state).thenReturn(
      const DevicesState(status: DevicesStatus.error, message: 'Server error'),
    );
    when(() => mockDevicesBloc.stream).thenAnswer((_) => const Stream.empty());

    // act
    await tester.pumpWidget(createWidgetUnderTest());

    // assert
    expect(find.text('Error: Server error'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });
}
