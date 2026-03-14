import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/error/exceptions.dart';
import '../models/alert_model.dart';

abstract class AlertsRemoteDataSource {
  Future<List<AlertModel>> getAlerts();
}

@LazySingleton(as: AlertsRemoteDataSource)
class AlertsRemoteDataSourceImpl implements AlertsRemoteDataSource {
  final DioClient _dioClient;

  AlertsRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<AlertModel>> getAlerts() async {
    try {
      final response = await _dioClient.get('/alerts');
      final dynamic data = response.data;
      final List<dynamic> alertsList;
      
      if (data is List) {
        alertsList = data;
      } else if (data is Map<String, dynamic> && data['data'] is List) {
        alertsList = data['data'] as List<dynamic>;
      } else {
        throw const FormatException('Unexpected response format');
      }

      return alertsList
          .map((json) => AlertModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to fetch alerts');
    }
  }
}
