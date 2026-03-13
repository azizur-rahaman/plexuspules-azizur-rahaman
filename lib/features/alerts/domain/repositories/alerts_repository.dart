import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/alert.dart';

abstract class AlertsRepository {
  Future<Either<Failure, List<Alert>>> getAlerts();
}
