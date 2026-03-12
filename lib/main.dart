import 'package:flutter/material.dart';
import 'package:plexuspules/app.dart';
import 'package:plexuspules/core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const PlexusPulseApp());
}
