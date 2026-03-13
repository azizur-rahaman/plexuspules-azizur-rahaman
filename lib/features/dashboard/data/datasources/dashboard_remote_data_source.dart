import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../models/dashboard_metrics_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardMetricsModel> getDashboardMetrics();
}

@LazySingleton(as: DashboardRemoteDataSource)
class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final DioClient _dioClient;

  DashboardRemoteDataSourceImpl(this._dioClient);

  @override
  Future<DashboardMetricsModel> getDashboardMetrics() async {
    try {
      final response = await _dioClient.get('/dashboard/metrics');
      return DashboardMetricsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch metrics');
    }
  }
}
