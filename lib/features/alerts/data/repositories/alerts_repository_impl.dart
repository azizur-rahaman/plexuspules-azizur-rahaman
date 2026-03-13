import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/alert.dart';
import '../../domain/repositories/alerts_repository.dart';
import '../datasources/alerts_remote_data_source.dart';

@LazySingleton(as: AlertsRepository)
class AlertsRepositoryImpl implements AlertsRepository {
  final AlertsRemoteDataSource remoteDataSource;

  AlertsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Alert>>> getAlerts() async {
    try {
      final remoteAlerts = await remoteDataSource.getAlerts();
      return Right(remoteAlerts);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
