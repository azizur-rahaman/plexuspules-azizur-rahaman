import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../auth/data/datasources/auth_local_data_source.dart';
import '../../domain/entities/notification_settings.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';
import '../models/notification_settings_model.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  final NetworkInfo _networkInfo;

  ProfileRepositoryImpl(
    this._remoteDataSource,
    this._authLocalDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, NotificationSettings>> getNotificationSettings() async {
    final isConnected = await _networkInfo.isConnected;
    if (!isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final settings = await _remoteDataSource.getNotificationSettings();
      return Right(settings);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateNotificationSettings(NotificationSettings settings) async {
    final isConnected = await _networkInfo.isConnected;
    if (!isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      await _remoteDataSource.updateNotificationSettings(
        NotificationSettingsModel.fromEntity(settings),
      );
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> registerFcmToken(String token) async {
    final isConnected = await _networkInfo.isConnected;
    if (!isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      await _remoteDataSource.registerFcmToken(token);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await _authLocalDataSource.clearToken();
      return const Right(unit);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
