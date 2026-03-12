import 'package:go_router/go_router.dart';
import 'package:plexuspules/features/auth/presentation/pages/login/login_page.dart';
import 'package:plexuspules/features/dashboard/presentation/pages/dashboard/dashboard_page.dart';
import 'package:plexuspules/features/devices/presentation/pages/devices/devices_page.dart';
import 'package:plexuspules/features/alerts/presentation/pages/alerts/alerts_page.dart';
import 'package:plexuspules/features/profile/presentation/pages/profile/profile_page.dart';
import 'package:plexuspules/core/navigation/navigation_shell_page.dart';
import 'package:plexuspules/features/splash/presentation/pages/splash_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String devices = '/devices';
  static const String alerts = '/alerts';
  static const String profile = '/profile';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavigationShellPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: dashboard,
                builder: (context, state) => const DashboardPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: devices,
                builder: (context, state) => const DevicesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: alerts,
                builder: (context, state) => const AlertsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
