import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/dashboard_metrics.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardMetrics>> getDashboardMetrics();
}
