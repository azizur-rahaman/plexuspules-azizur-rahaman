import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/notification_settings.dart';

abstract class ProfileRepository {
  Future<Either<Failure, NotificationSettings>> getNotificationSettings();
  Future<Either<Failure, Unit>> updateNotificationSettings(NotificationSettings settings);
  Future<Either<Failure, Unit>> registerFcmToken(String token);
  Future<Either<Failure, Unit>> logout();
}
