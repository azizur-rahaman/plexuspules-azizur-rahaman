import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

/// A labelled email text field with built-in validation.
class LoginEmailField extends StatelessWidget {
  final TextEditingController controller;

  const LoginEmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EMAIL ADDRESS',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
            letterSpacing: 0.5.w,
          ),
        ),
        AppSizes.gap8,
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            hintText: 'name@company.com',
            prefixIcon: Icon(Icons.email_outlined),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Email is required';
            }
            final emailRegex = RegExp(
              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
            );
            if (!emailRegex.hasMatch(value.trim())) {
              return 'Enter a valid email address';
            }
            return null;
          },
        ),
      ],
    );
  }
}
