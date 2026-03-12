import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:plexuspules/app.dart';
import 'package:plexuspules/core/di/injection.dart';
import 'package:plexuspules/core/services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await configureDependencies();
  await getIt<HiveService>().init();
  runApp(const PlexusPulseApp());
}
