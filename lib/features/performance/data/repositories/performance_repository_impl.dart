import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/performance_metrics.dart';
import '../../domain/repositories/performance_repository.dart';
import '../datasources/performance_remote_data_source.dart';

@LazySingleton(as: PerformanceRepository)
class PerformanceRepositoryImpl implements PerformanceRepository {
  final PerformanceRemoteDataSource remoteDataSource;

  PerformanceRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PerformanceMetrics>> getPerformanceMetrics() async {
    try {
      final remoteMetrics = await remoteDataSource.getPerformanceMetrics();
      return Right(remoteMetrics);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
