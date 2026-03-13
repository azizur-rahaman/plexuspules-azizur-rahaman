import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:plexuspules/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:plexuspules/features/profile/domain/repositories/profile_repository.dart';

@lazySingleton
class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final ProfileRepository _profileRepository;
  final AuthLocalDataSource _authLocalDataSource;

  PushNotificationService(this._profileRepository, this._authLocalDataSource);

  Future<void> initialize() async {
    // 1. Request permissions
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // 2. Register current token if authenticated
      await _checkAndRegisterToken();

      // 3. Listen for token refresh
      _fcm.onTokenRefresh.listen((newToken) async {
        await _checkAndRegisterToken(newToken);
      });

      // 4. Handle Foreground Messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // App logic for foreground notifications
      });

      // 5. Handle Background/Terminated state clicks
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        // Navigation logic
      });
    }
  }

  Future<void> _checkAndRegisterToken([String? token]) async {
    try {
      // Only register if we have a cached auth token
      await _authLocalDataSource.getCachedToken();
      
      final fcmToken = token ?? await _fcm.getToken();
      if (fcmToken != null) {
        await _profileRepository.registerFcmToken(fcmToken);
      }
    } catch (_) {
      // Not authenticated yet, skipping registration
    }
  }

  /// Public method to be called after successful login
  Future<void> registerToken() async {
    await _checkAndRegisterToken();
  }
}
