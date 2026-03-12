import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';

/// Footer with a "New to PlexusPulse? Create account" link.
class LoginFooter extends StatelessWidget {
  final VoidCallback? onCreateAccount;

  const LoginFooter({super.key, this.onCreateAccount});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onCreateAccount,
        child: RichText(
          text: TextSpan(
            text: 'New to PlexusPulse? ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
            children: [
              TextSpan(
                text: 'Create account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
