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

import '../../features/auth/data/datasources/auth_local_data_source.dart'
    as _i852;
import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/presentation/bloc/login_bloc.dart' as _i990;
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart'
    as _i652;
import '../../features/devices/presentation/bloc/device_detail_bloc.dart'
    as _i518;
import '../../features/devices/presentation/bloc/devices_bloc.dart' as _i517;
import '../../features/monitoring/data/datasources/monitoring_remote_data_source.dart'
    as _i1059;
import '../../features/monitoring/data/repositories/monitoring_repository_impl.dart'
    as _i592;
import '../../features/monitoring/domain/repositories/monitoring_repository.dart'
    as _i365;
import '../../features/monitoring/domain/usecases/get_dashboard_metrics.dart'
    as _i74;
import '../../features/monitoring/domain/usecases/get_device_details.dart'
    as _i91;
import '../../features/monitoring/domain/usecases/get_devices.dart' as _i249;
import '../../features/profile/presentation/blocs/theme/theme_bloc.dart'
    as _i766;
import '../network/dio_client.dart' as _i667;
import '../network/network_info.dart' as _i932;
import '../services/hive_service.dart' as _i1047;
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
    gh.factory<_i652.DashboardBloc>(
      () => _i652.DashboardBloc(gh<_i74.GetDashboardMetrics>()),
    );
    gh.lazySingleton<_i932.NetworkInfo>(
      () => _i932.NetworkInfoImpl(gh<_i895.Connectivity>()),
    );
    gh.lazySingleton<_i107.AuthRemoteDataSource>(
      () => _i107.AuthRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i852.AuthLocalDataSource>(
      () => _i852.AuthLocalDataSourceImpl(gh<_i535.SecureStorageService>()),
    );
    gh.factory<_i517.DevicesBloc>(
        () => _i517.DevicesBloc(gh<_i249.GetDevices>()));
    gh.factory<_i518.DeviceDetailBloc>(
      () => _i518.DeviceDetailBloc(gh<_i91.GetDeviceDetails>()),
    );
    gh.lazySingleton<_i1059.MonitoringRemoteDataSource>(
      () => _i1059.MonitoringRemoteDataSourceImpl(gh<_i667.DioClient>()),
    );
    gh.lazySingleton<_i365.MonitoringRepository>(
      () => _i592.MonitoringRepositoryImpl(
        gh<_i1059.MonitoringRemoteDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        gh<_i107.AuthRemoteDataSource>(),
        gh<_i852.AuthLocalDataSource>(),
        gh<_i932.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i188.LoginUseCase>(
      () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i74.GetDashboardMetrics>(
      () => _i74.GetDashboardMetrics(gh<_i365.MonitoringRepository>()),
    );
    gh.lazySingleton<_i91.GetDeviceDetails>(
      () => _i91.GetDeviceDetails(gh<_i365.MonitoringRepository>()),
    );
    gh.lazySingleton<_i249.GetDevices>(
      () => _i249.GetDevices(gh<_i365.MonitoringRepository>()),
    );
    gh.factory<_i990.LoginBloc>(
      () => _i990.LoginBloc(gh<_i188.LoginUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
