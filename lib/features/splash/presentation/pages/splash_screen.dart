import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:plexuspules/config/app_router.dart';
import 'package:plexuspules/core/di/injection.dart';
import 'package:plexuspules/features/auth/domain/repositories/auth_repository.dart';
import '../../../../core/constants/app_sizes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final authRepository = getIt<AuthRepository>();
    final result = await authRepository.getCachedToken();

    result.fold(
      (failure) => context.go(AppRouter.login),
      (token) => context.go(AppRouter.dashboard),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).colorScheme.secondaryContainer,
            ],
            stops: const [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Logo
              Image.asset(
                'assets/brand-logo-icon.png',
                width: AppSizes.splashLogoSize,
                height: AppSizes.splashLogoSize,
                fit: BoxFit.contain,
              ),

              AppSizes.gap24,

              // App Title
              Text(
                'PlexusPulse',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: AppSizes.font32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: -0.5.w,
                ),
              ),

              AppSizes.gap8,

              // Subtitle
              Text(
                'SMART NETWORK MONITORING',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontSize: AppSizes.font12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5.w,
                ),
              ),

              const Spacer(flex: 2),

              // Loading Indicator
              Padding(
                padding: EdgeInsets.only(bottom: AppSizes.p48),
                child: LoadingAnimationWidget.horizontalRotatingDots(
                  color: Theme.of(context).colorScheme.primary,
                  size: AppSizes.iconXXXLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
