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
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                color: Color(0xFF2F6B4F),
                fontWeight: FontWeight.bold,
                fontSize: 10,
              );
            }
            return const TextStyle(
              color: Color(0xFF94A3B8),
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
              icon: const Icon(Icons.dashboard_outlined, color: Color(0xFF94A3B8)),
              selectedIcon: const Icon(Icons.dashboard, color: Color(0xFF2F6B4F)),
              label: 'DASHBOARD',
            ),
            NavigationDestination(
              icon: const Icon(Icons.devices_outlined, color: Color(0xFF94A3B8)),
              selectedIcon: const Icon(Icons.devices, color: Color(0xFF2F6B4F)),
              label: 'DEVICES',
            ),
            NavigationDestination(
              icon: const Icon(Icons.notifications_outlined, color: Color(0xFF94A3B8)),
              selectedIcon: const Icon(Icons.notifications, color: Color(0xFF2F6B4F)),
              label: 'ALERTS',
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline, color: Color(0xFF94A3B8)),
              selectedIcon: const Icon(Icons.person, color: Color(0xFF2F6B4F)),
              label: 'PROFILE',
            ),
          ],
        ),
      ),
    );
  }
}
