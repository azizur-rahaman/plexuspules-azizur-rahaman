import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plexuspules/firebase_options.dart';
import 'package:plexuspules/app.dart';
import 'package:plexuspules/core/di/injection.dart';
import 'package:plexuspules/core/services/hive_service.dart';
import 'package:plexuspules/core/services/push_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  await configureDependencies();
  await getIt<HiveService>().init();
  await getIt<PushNotificationService>().initialize();
  runApp(const PlexusPulseApp());
}
