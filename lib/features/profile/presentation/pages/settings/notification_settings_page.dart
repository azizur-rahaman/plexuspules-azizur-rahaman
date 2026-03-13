import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plexuspules/config/theme/app_colors.dart';
import 'package:plexuspules/core/constants/app_sizes.dart';
import 'package:plexuspules/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:plexuspules/features/profile/presentation/bloc/profile_event.dart';
import 'package:plexuspules/features/profile/presentation/bloc/profile_state.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Notification Settings'),
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final settings = state.settings;
          if (settings == null) {
            return const Center(child: Text('Failed to load settings'));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(AppSizes.p24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PREFERENCES',
                  style: TextStyle(
                    fontSize: AppSizes.font12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary.withValues(alpha: 0.7),
                    letterSpacing: 1.2,
                  ),
                ),
                AppSizes.gap12,
                Container(
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                    border: Border.all(
                      color: theme.brightness == Brightness.light
                          ? AppColors.cardBorder
                          : AppColors.cardBorderDark,
                    ),
                  ),
                  child: Column(
                    children: [
                      _SettingToggle(
                        title: 'Push Notifications',
                        subtitle: 'Receive alerts on your device',
                        value: settings.pushEnabled,
                        onChanged: (val) {
                          context.read<ProfileBloc>().add(
                                UpdateNotificationSettings(
                                  settings.copyWith(pushEnabled: val),
                                ),
                              );
                        },
                      ),
                      const Divider(height: 1, indent: 16),
                      _SettingToggle(
                        title: 'Email Alerts',
                        subtitle: 'Receive reports via email',
                        value: settings.emailEnabled,
                        onChanged: (val) {
                          context.read<ProfileBloc>().add(
                                UpdateNotificationSettings(
                                  settings.copyWith(emailEnabled: val),
                                ),
                              );
                        },
                      ),
                    ],
                  ),
                ),
                AppSizes.gap32,
                Text(
                  'ALERT THRESHOLDS',
                  style: TextStyle(
                    fontSize: AppSizes.font12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary.withValues(alpha: 0.7),
                    letterSpacing: 1.2,
                  ),
                ),
                AppSizes.gap12,
                Container(
                  padding: EdgeInsets.all(AppSizes.p16),
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                    border: Border.all(
                      color: theme.brightness == Brightness.light
                          ? AppColors.cardBorder
                          : AppColors.cardBorderDark,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('CPU/Memory Usage Alert'),
                          Text(
                            '${settings.alertThreshold.toInt()}%',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      AppSizes.gap8,
                      Slider.adaptive(
                        value: settings.alertThreshold,
                        min: 50,
                        max: 95,
                        divisions: 45,
                        onChanged: (val) {
                          context.read<ProfileBloc>().add(
                                UpdateNotificationSettings(
                                  settings.copyWith(alertThreshold: val),
                                ),
                              );
                        },
                        activeColor: AppColors.primary,
                      ),
                      Text(
                        'Trigger notification when device usage exceeds this level',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SettingToggle extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingToggle({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeTrackColor: AppColors.primary,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.p16, vertical: 4.h),
    );
  }
}
