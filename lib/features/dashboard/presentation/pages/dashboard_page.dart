import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.dashboard_outlined,
              size: AppSizes.iconXXXLarge * 2,
              color: Theme.of(context).colorScheme.primary,
            ),
            AppSizes.gap24,
            Text(
              'Welcome to PlexusPulse',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            AppSizes.gap8,
            Text(
              'Network Monitoring Dashboard',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
