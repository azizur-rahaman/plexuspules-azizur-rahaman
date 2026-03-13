import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

class CriticalAlertPopup extends StatelessWidget {
  final String deviceName;
  final String ipAddress;
  final String location;
  final String timeDetected;
  final VoidCallback onViewDevice;
  final VoidCallback onDismiss;

  const CriticalAlertPopup({
    super.key,
    required this.deviceName,
    required this.ipAddress,
    required this.location,
    required this.timeDetected,
    required this.onViewDevice,
    required this.onDismiss,
  });

  static Future<void> show(
    BuildContext context, {
    required String deviceName,
    required String ipAddress,
    required String location,
    required String timeDetected,
    required VoidCallback onViewDevice,
    required VoidCallback onDismiss,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CriticalAlertPopup(
        deviceName: deviceName,
        ipAddress: ipAddress,
        location: location,
        timeDetected: timeDetected,
        onViewDevice: onViewDevice,
        onDismiss: onDismiss,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusXLarge * 1.5),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.p24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(AppSizes.p8),
                  decoration: BoxDecoration(
                    color: AppColors.critical.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.error,
                    color: AppColors.critical,
                    size: AppSizes.iconMedium,
                  ),
                ),
                AppSizes.gap12,
                Text(
                  'Device Offline Alert',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                AppSizes.gap12,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.p8,
                    vertical: AppSizes.p2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.critical,
                    borderRadius: BorderRadius.circular(AppSizes.radiusCircular),
                  ),
                  child: Text(
                    'CRITICAL',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppSizes.font10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            AppSizes.gap24,
            // Main Message
            Text(
              '$deviceName has gone offline',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            AppSizes.gap32,
            // Info Grid
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoTile(label: 'DEVICE NAME', value: deviceName),
                _InfoTile(label: 'IP ADDRESS', value: ipAddress),
              ],
            ),
            AppSizes.gap24,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoTile(label: 'LOCATION', value: location),
                _InfoTile(label: 'TIME DETECTED', value: timeDetected),
              ],
            ),
            AppSizes.gap40,
            // Button Actions
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onViewDevice();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: AppSizes.p16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'View Device',
                      style: TextStyle(
                        fontSize: AppSizes.font16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppSizes.gap8,
                    Icon(Icons.arrow_forward, size: AppSizes.iconSmall),
                  ],
                ),
              ),
            ),
            AppSizes.gap12,
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onDismiss();
              },
              child: Text(
                'Dismiss',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: AppSizes.font16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: AppSizes.font10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        AppSizes.gap4,
        Text(
          value,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppSizes.font14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
