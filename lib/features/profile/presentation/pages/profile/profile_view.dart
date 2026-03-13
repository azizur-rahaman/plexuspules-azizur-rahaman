import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plexuspules/config/theme/app_colors.dart';
import 'package:plexuspules/core/constants/app_sizes.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.p24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header Logo
              Center(
                child: Image.asset('assets/brand-logo-icon.png', height: 32.h),
              ),
              AppSizes.gap32,

              // Profile Avatar Section
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 50.r,
                      backgroundColor: const Color(0xffBDCBD0),
                      child: Icon(
                        Icons.person,
                        size: 60.r,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4.w,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit, size: 14.r, color: Colors.white),
                    ),
                  ),
                ],
              ),
              AppSizes.gap16,

              // Name and Email
              Text(
                'Admin',
                style: TextStyle(
                  fontSize: AppSizes.font24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              AppSizes.gap4,
              Text(
                'admin@plexus.com',
                style: TextStyle(
                  fontSize: AppSizes.font16,
                  color: AppColors.textSecondary,
                ),
              ),
              AppSizes.gap16,

              // Status Badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.p12,
                  vertical: AppSizes.p4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2EDEA), // Pale green from mockup
                  borderRadius: BorderRadius.circular(AppSizes.radiusCircular),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8.r,
                      height: 8.r,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    AppSizes.gap8,
                    Text(
                      'SYSTEM ADMINISTRATOR',
                      style: TextStyle(
                        fontSize: AppSizes.font10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.p40),

              // Application Settings Header
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'APPLICATION SETTINGS',
                  style: TextStyle(
                    fontSize: AppSizes.font12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary.withValues(alpha: 0.7),
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              AppSizes.gap12,

              // Settings Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _SettingsTile(
                      icon: Icons.dark_mode_outlined,
                      title: 'Dark Mode',
                      subtitle: 'Adjust the visual appearance',
                      trailing: Switch.adaptive(
                        value: false,
                        onChanged: (val) {},
                        activeTrackColor: AppColors.primary,
                      ),
                    ),
                    const Divider(height: 1, indent: 56),
                    _SettingsTile(
                      icon: Icons.notifications_none_outlined,
                      title: 'Notification Settings',
                      subtitle: 'Alerts, push & email preferences',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              AppSizes.gap32,

              // Logout Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: AppSizes.p16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                  ),
                  minimumSize: const Size(double.infinity, 0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.logout_outlined),
                    AppSizes.gap8,
                    Text(
                      'Logout from PlexusPulse',
                      style: TextStyle(
                        fontSize: AppSizes.font16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              AppSizes.gap24,

              // Version Info
              Text(
                'VERSION 4.2.0-STABLE | BUILD 8812',
                style: TextStyle(
                  fontSize: AppSizes.font10,
                  color: AppColors.textSecondary.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppSizes.gap16,
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F5F2),
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20.r),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: AppSizes.font16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: AppSizes.font12,
          color: AppColors.textSecondary,
        ),
      ),
      trailing:
          trailing ??
          Icon(
            Icons.chevron_right,
            color: AppColors.textSecondary.withValues(alpha: 0.5),
            size: 20.r,
          ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSizes.p16,
        vertical: 4.h,
      ),
    );
  }
}
