import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/performance_metrics.dart';

abstract class PerformanceRepository {
  Future<Either<Failure, PerformanceMetrics>> getPerformanceMetrics();
}
