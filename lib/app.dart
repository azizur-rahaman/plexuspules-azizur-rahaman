import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';

class PlexusPulseApp extends StatelessWidget {
  const PlexusPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plexus Pulse',
      theme: AppTheme.lightTheme,
      home: const Scaffold(
        body: Center(
          child: Text('Plexus Pulse Initialization...'),
        ),
      ),
    );
  }
}
