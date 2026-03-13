import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/performance_metrics.dart';
import '../repositories/performance_repository.dart';

@lazySingleton
class GetPerformanceMetrics {
  final PerformanceRepository repository;

  GetPerformanceMetrics(this.repository);

  Future<Either<Failure, PerformanceMetrics>> call() async {
    return await repository.getPerformanceMetrics();
  }
}
