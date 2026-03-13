// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/alerts/data/datasources/alerts_remote_data_source.dart'
    as _i956;
import '../../features/alerts/data/repositories/alerts_repository_impl.dart'
    as _i56;
import '../../features/alerts/domain/repositories/alerts_repository.dart'
    as _i7;
import '../../features/alerts/domain/usecases/get_alerts.dart' as _i406;
import '../../features/alerts/presentation/bloc/alerts_bloc.dart' as _i24;
import '../../features/auth/data/datasources/auth_local_data_source.dart'
    as _i852;
import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/presentation/bloc/login_bloc.dart' as _i990;
import '../../features/dashboard/data/datasources/dashboard_remote_data_source.dart'
    as _i258;
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart'
    as _i509;
import '../../features/dashboard/domain/repositories/dashboard_repository.dart'
    as _i665;
import '../../features/dashboard/domain/usecases/get_dashboard_metrics.dart'
    as _i639;
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart'
    as _i652;
import '../../features/devices/data/datasources/devices_remote_data_source.dart'
    as _i748;
import '../../features/devices/data/repositories/devices_repository_impl.dart'
    as _i196;
import '../../features/devices/domain/repositories/devices_repository.dart'
    as _i1072;
import '../../features/devices/domain/usecases/get_device_details.dart'
    as _i413;
import '../../features/devices/domain/usecases/get_devices.dart' as _i426;
import '../../features/devices/presentation/bloc/device_detail_bloc.dart'
    as _i722;
import '../../features/devices/presentation/bloc/devices_bloc.dart' as _i517;
import '../../features/performance/data/datasources/performance_remote_data_source.dart'
    as _i629;
import '../../features/performance/data/repositories/performance_repository_impl.dart'
    as _i239;
import '../../features/performance/domain/repositories/performance_repository.dart'
    as _i323;
import '../../features/performance/domain/usecases/get_performance_metrics.dart'
    as _i498;
import '../../features/performance/presentation/bloc/performance_bloc.dart'
    as _i58;
import '../../features/profile/data/datasources/profile_remote_data_source.dart'
    as _i847;
import '../../features/profile/data/repositories/profile_repository_impl.dart'
    as _i334;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i894;
import '../../features/profile/presentation/bloc/profile_bloc.dart' as _i469;
import '../../features/profile/presentation/blocs/theme/theme_bloc.dart'
    as _i766;
import '../network/dio_client.dart' as _i667;
import '../network/network_info.dart' as _i932;
import '../services/hive_service.dart' as _i1047;
import '../services/push_notification_service.dart' as _i63;
import '../services/secure_storage_service.dart' as _i535;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.lazySingleton<_i1047.HiveService>(() => _i1047.HiveService());
    gh.factory<_i766.ThemeBloc>(
      () => _i766.ThemeBloc(gh<_i1047.HiveService>()),
    );
    gh.lazySingleton<_i535.SecureStorageService>(
      () => _i535.SecureStorageService(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i667.DioClient>(
      () => _i667.DioClient(gh<_i535.SecureStorageService>()),
    );
    gh.lazySingleton<_i932.NetworkInfo>(
      () => _i932.NetworkInfoImpl(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i107.AuthRemoteDataSource>(
      () => _i107.AuthRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i956.AlertsRemoteDataSource>(
      () => _i956.AlertsRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i847.ProfileRemoteDataSource>(
      () => _i847.ProfileRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i748.DevicesRemoteDataSource>(
      () => _i748.DevicesRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i258.DashboardRemoteDataSource>(
      () => _i258.DashboardRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i852.AuthLocalDataSource>(
      () => _i852.AuthLocalDataSourceImpl(gh<_i535.SecureStorageService>()),
    );
    gh.lazySingleton<_i7.AlertsRepository>(
      () => _i56.AlertsRepositoryImpl(gh<_i956.AlertsRemoteDataSource>()),
    );
    gh.lazySingleton<_i629.PerformanceRemoteDataSource>(
      () => _i629.PerformanceRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        gh<_i107.AuthRemoteDataSource>(),
        gh<_i852.AuthLocalDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i894.ProfileRepository>(
      () => _i334.ProfileRepositoryImpl(
        gh<_i847.ProfileRemoteDataSource>(),
        gh<_i852.AuthLocalDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i1072.DevicesRepository>(
      () => _i196.DevicesRepositoryImpl(
        gh<_i748.DevicesRemoteDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i406.GetAlerts>(
      () => _i406.GetAlerts(gh<_i7.AlertsRepository>()),
    );
    gh.factory<_i469.ProfileBloc>(
      () => _i469.ProfileBloc(gh<_i894.ProfileRepository>()),
    );
    gh.lazySingleton<_i188.LoginUseCase>(
      () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i323.PerformanceRepository>(
      () => _i239.PerformanceRepositoryImpl(
        gh<_i629.PerformanceRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i665.DashboardRepository>(
      () => _i509.DashboardRepositoryImpl(
        gh<_i258.DashboardRemoteDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i639.GetDashboardMetrics>(
      () => _i639.GetDashboardMetrics(gh<_i665.DashboardRepository>()),
    );
    gh.factory<_i652.DashboardBloc>(
      () => _i652.DashboardBloc(gh<_i639.GetDashboardMetrics>()),
    );
    gh.lazySingleton<_i63.PushNotificationService>(
      () => _i63.PushNotificationService(
        gh<_i894.ProfileRepository>(),
        gh<_i852.AuthLocalDataSource>(),
      ),
    );
    gh.factory<_i24.AlertsBloc>(() => _i24.AlertsBloc(gh<_i406.GetAlerts>()));
    gh.factory<_i990.LoginBloc>(
      () => _i990.LoginBloc(gh<_i188.LoginUseCase>()),
    );
    gh.lazySingleton<_i413.GetDeviceDetails>(
      () => _i413.GetDeviceDetails(gh<_i1072.DevicesRepository>()),
    );
    gh.lazySingleton<_i426.GetDevices>(
      () => _i426.GetDevices(gh<_i1072.DevicesRepository>()),
    );
    gh.lazySingleton<_i498.GetPerformanceMetrics>(
      () => _i498.GetPerformanceMetrics(gh<_i323.PerformanceRepository>()),
    );
    gh.factory<_i58.PerformanceBloc>(
      () => _i58.PerformanceBloc(gh<_i498.GetPerformanceMetrics>()),
    );
    gh.factory<_i722.DeviceDetailBloc>(
      () => _i722.DeviceDetailBloc(gh<_i413.GetDeviceDetails>()),
    );
    gh.factory<_i517.DevicesBloc>(
      () => _i517.DevicesBloc(gh<_i426.GetDevices>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
