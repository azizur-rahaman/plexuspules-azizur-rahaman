import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_sizes.dart';

/// Displays the brand logo, app title, and subtitle at the top of the login screen.
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: ScreenUtil().screenHeight * 0.15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/brand-logo-icon.png',
              width: 80.w,
              height: 80.w,
              fit: BoxFit.contain,
            ),
            AppSizes.gap16,
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
            Text(
              'NETWORK MONITORING DASHBOARD',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontSize: AppSizes.font12,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
                letterSpacing: 1.5.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
