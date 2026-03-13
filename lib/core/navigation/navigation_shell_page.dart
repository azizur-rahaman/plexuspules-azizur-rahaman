import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationShellPage extends StatelessWidget {
  const NavigationShellPage({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: theme.brightness == Brightness.light
              ? Colors.white
              : theme.colorScheme.surface,
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              );
            }
            return TextStyle(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
              fontSize: 10,
            );
          }),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) => _onTap(context, index),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          height: 80,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.dashboard_outlined,
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
              selectedIcon: Icon(
                Icons.dashboard,
                color: theme.colorScheme.primary,
              ),
              label: 'DASHBOARD',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.devices_outlined,
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
              selectedIcon: Icon(
                Icons.devices,
                color: theme.colorScheme.primary,
              ),
              label: 'DEVICES',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.analytics_outlined,
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
              selectedIcon: Icon(
                Icons.analytics,
                color: theme.colorScheme.primary,
              ),
              label: 'PERFORMANCE',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person_outline,
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
              selectedIcon: Icon(
                Icons.person,
                color: theme.colorScheme.primary,
              ),
              label: 'PROFILE',
            ),
          ],
        ),
      ),
    );
  }
}
