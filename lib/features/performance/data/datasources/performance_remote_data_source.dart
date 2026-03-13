import 'package:injectable/injectable.dart';
import '../models/performance_metrics_model.dart';
import '../../../../core/network/dio_client.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';

abstract class PerformanceRemoteDataSource {
  Future<PerformanceMetricsModel> getPerformanceMetrics();
}

@LazySingleton(as: PerformanceRemoteDataSource)
class PerformanceRemoteDataSourceImpl implements PerformanceRemoteDataSource {
  final DioClient _dioClient;

  PerformanceRemoteDataSourceImpl(this._dioClient);

  @override
  Future<PerformanceMetricsModel> getPerformanceMetrics() async {
    try {
      final response = await _dioClient.get('/performance/metrics');
      return PerformanceMetricsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch performance metrics');
    }
  }
}
