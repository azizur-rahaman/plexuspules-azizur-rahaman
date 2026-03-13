import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:plexuspules/core/services/push_notification_service.dart';
import 'package:plexuspules/features/devices/presentation/bloc/devices_event.dart';
import 'package:plexuspules/features/devices/presentation/bloc/devices_state.dart';
import 'package:dio/dio.dart';
import 'package:plexuspules/core/network/dio_client.dart';
import 'package:plexuspules/features/auth/domain/repositories/auth_repository.dart';
import 'package:plexuspules/features/auth/domain/usecases/login_usecase.dart';
import 'package:plexuspules/features/auth/presentation/bloc/login_bloc.dart';
import 'package:plexuspules/features/auth/presentation/bloc/login_event.dart';
import 'package:plexuspules/features/auth/presentation/bloc/login_state.dart';
import 'package:plexuspules/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:plexuspules/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:plexuspules/core/network/network_info.dart';

import 'package:plexuspules/features/auth/data/models/auth_request_model.dart';

import 'package:plexuspules/core/services/secure_storage_service.dart';

import 'package:plexuspules/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:plexuspules/features/dashboard/domain/usecases/get_dashboard_metrics.dart';
import 'package:plexuspules/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:plexuspules/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:plexuspules/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:plexuspules/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:plexuspules/features/devices/data/datasources/devices_remote_data_source.dart';
import 'package:plexuspules/features/devices/domain/repositories/devices_repository.dart';
import 'package:plexuspules/features/devices/domain/usecases/get_devices.dart';
import 'package:plexuspules/features/devices/domain/usecases/get_device_details.dart';
import 'package:plexuspules/features/devices/presentation/bloc/devices_bloc.dart';
import 'package:plexuspules/features/devices/presentation/bloc/device_detail_bloc.dart';
import 'package:plexuspules/features/devices/presentation/bloc/device_detail_event.dart';
import 'package:plexuspules/features/devices/presentation/bloc/device_detail_state.dart';

class MockDio extends Mock implements Dio {}
class MockDioClient extends Mock implements DioClient {}
class MockAuthRepository extends Mock implements AuthRepository {}
class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockLoginBloc extends MockBloc<LoginEvent, LoginState> implements LoginBloc {}
class MockDashboardRepository extends Mock implements DashboardRepository {}
class MockGetDashboardMetricsUseCase extends Mock implements GetDashboardMetrics {}
class MockDashboardBloc extends MockBloc<DashboardEvent, DashboardState> implements DashboardBloc {}
class MockDashboardRemoteDataSource extends Mock implements DashboardRemoteDataSource {}
class MockDevicesRepository extends Mock implements DevicesRepository {}
class MockGetDevicesUseCase extends Mock implements GetDevices {}
class MockGetDeviceDetailsUseCase extends Mock implements GetDeviceDetails {}
class MockDevicesBloc extends MockBloc<DevicesEvent, DevicesState> implements DevicesBloc {}
class MockDeviceDetailBloc extends MockBloc<DeviceDetailEvent, DeviceDetailState> implements DeviceDetailBloc {}
class MockDevicesRemoteDataSource extends Mock implements DevicesRemoteDataSource {}
class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}
class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}
class MockSecureStorageService extends Mock implements SecureStorageService {}
class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}
class MockPushNotificationService extends Mock implements PushNotificationService {}

// Fake classes for Mocktail if needed for registration
class FakeLoginEvent extends Fake implements LoginEvent {}
class FakeLoginState extends Fake implements LoginState {}
class FakeAuthRequestModel extends Fake implements AuthRequestModel {}
class FakeLoginParams extends Fake implements LoginParams {}
class FakeDashboardEvent extends Fake implements DashboardEvent {}
class FakeDashboardState extends Fake implements DashboardState {}
class FakeGetDevicesParams extends Fake implements GetDevicesParams {}
class FakeDeviceDetailEvent extends Fake implements DeviceDetailEvent {}
class FakeDeviceDetailState extends Fake implements DeviceDetailState {}

void registerTestFallbacks() {
  registerFallbackValue(FakeLoginEvent());
  registerFallbackValue(FakeLoginState());
  registerFallbackValue(FakeAuthRequestModel());
  registerFallbackValue(FakeLoginParams());
  registerFallbackValue(FakeDashboardEvent());
  registerFallbackValue(FakeDashboardState());
  registerFallbackValue(FakeGetDevicesParams());
  registerFallbackValue(FakeDeviceDetailEvent());
  registerFallbackValue(FakeDeviceDetailState());
}
