import 'package:injectable/injectable.dart';
import '../models/notification_settings_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';

abstract class ProfileRemoteDataSource {
  Future<NotificationSettingsModel> getNotificationSettings();
  Future<void> updateNotificationSettings(NotificationSettingsModel settings);
  Future<void> registerFcmToken(String token);
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioClient _dioClient;

  ProfileRemoteDataSourceImpl(this._dioClient);

  @override
  Future<NotificationSettingsModel> getNotificationSettings() async {
    try {
      final response = await _dioClient.get('/notifications/settings');
      return NotificationSettingsModel.fromJson(response.data['data']);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateNotificationSettings(NotificationSettingsModel settings) async {
    try {
      await _dioClient.post('/notifications/settings', data: settings.toJson());
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> registerFcmToken(String token) async {
    try {
      await _dioClient.post('/notifications/register-token', data: {'token': token});
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }
}
