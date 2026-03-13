import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/dashboard_metrics.dart';
import '../../domain/entities/device.dart';
import '../../domain/repositories/monitoring_repository.dart';
import '../datasources/monitoring_remote_data_source.dart';

@LazySingleton(as: MonitoringRepository)
class MonitoringRepositoryImpl implements MonitoringRepository {
  final MonitoringRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  MonitoringRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, DashboardMetrics>> getDashboardMetrics() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final metrics = await _remoteDataSource.getDashboardMetrics();
      return Right(metrics);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Device>>> getDevices({
    String? search,
    String? status,
    int? page,
    int? limit,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final devices = await _remoteDataSource.getDevices(
        search: search,
        status: status,
        page: page,
        limit: limit,
      );
      return Right(devices);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Device>> getDeviceDetails(String id) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final device = await _remoteDataSource.getDeviceDetails(id);
      return Right(device);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
