import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/dashboard_metrics.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_data_source.dart';

@LazySingleton(as: DashboardRepository)
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  DashboardRepositoryImpl(this._remoteDataSource, this._networkInfo);

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
}
