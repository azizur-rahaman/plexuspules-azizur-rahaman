import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/dashboard_metrics.dart';
import '../repositories/dashboard_repository.dart';

@lazySingleton
class GetDashboardMetrics {
  final DashboardRepository _repository;

  GetDashboardMetrics(this._repository);

  Future<Either<Failure, DashboardMetrics>> call() {
    return _repository.getDashboardMetrics();
  }
}
