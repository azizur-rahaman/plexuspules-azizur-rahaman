import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../models/device_model.dart';

abstract class DevicesRemoteDataSource {
  Future<List<DeviceModel>> getDevices({
    String? search,
    String? status,
    int? page,
    int? limit,
  });
  Future<DeviceModel> getDeviceDetails(String id);
}

@LazySingleton(as: DevicesRemoteDataSource)
class DevicesRemoteDataSourceImpl implements DevicesRemoteDataSource {
  final DioClient _dioClient;

  DevicesRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<DeviceModel>> getDevices({
    String? search,
    String? status,
    int? page,
    int? limit,
  }) async {
    try {
      final response = await _dioClient.get(
        '/devices',
        queryParameters: {
          'search': search,
          'status': status,
          'page': page,
          'limit': limit,
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
      final response = await _dioClient.get('/devices/$id');
      return DeviceModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch device details');
    }
  }
}
