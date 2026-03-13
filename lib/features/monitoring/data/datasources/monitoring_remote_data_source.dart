import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../models/dashboard_metrics_model.dart';
import '../models/device_model.dart';

abstract class MonitoringRemoteDataSource {
  Future<DashboardMetricsModel> getDashboardMetrics();
  Future<List<DeviceModel>> getDevices({
    String? search,
    String? status,
    int? page,
    int? limit,
  });
  Future<DeviceModel> getDeviceDetails(String id);
}

@LazySingleton(as: MonitoringRemoteDataSource)
class MonitoringRemoteDataSourceImpl implements MonitoringRemoteDataSource {
  final DioClient _dioClient;

  MonitoringRemoteDataSourceImpl(this._dioClient);

  @override
  Future<DashboardMetricsModel> getDashboardMetrics() async {
    try {
      final response = await _dioClient.get('/monitoring/metrics');
      return DashboardMetricsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch metrics');
    }
  }

  @override
  Future<List<DeviceModel>> getDevices({
    String? search,
    String? status,
    int? page,
    int? limit,
  }) async {
    try {
      final response = await _dioClient.get(
        '/monitoring/devices',
        queryParameters: {
          if (search != null) 'search': search,
          if (status != null) 'status': status,
          if (page != null) 'page': page,
          if (limit != null) 'limit': limit,
        },
      );
      
      return (response.data as List)
          .map((device) => DeviceModel.fromJson(device))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch devices');
    }
  }

  @override
  Future<DeviceModel> getDeviceDetails(String id) async {
    try {
      final response = await _dioClient.get('/monitoring/devices/$id');
      return DeviceModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch device details');
    }
  }
}
