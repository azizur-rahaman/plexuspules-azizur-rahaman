import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/alert.dart';
import '../repositories/alerts_repository.dart';

@lazySingleton
class GetAlerts {
  final AlertsRepository repository;

  GetAlerts(this.repository);

  Future<Either<Failure, List<Alert>>> call() async {
    return await repository.getAlerts();
  }
}
