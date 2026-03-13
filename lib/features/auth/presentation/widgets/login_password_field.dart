import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

/// A labelled password field with show/hide toggle and a "Forgot Password?" link.
class LoginPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onSubmitted;

  const LoginPasswordField({
    super.key,
    required this.controller,
    this.onForgotPassword,
    this.onSubmitted,
  });

  @override
  State<LoginPasswordField> createState() => _LoginPasswordFieldState();
}

class _LoginPasswordFieldState extends State<LoginPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PASSWORD',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
                letterSpacing: 0.5.w,
              ),
            ),
            GestureDetector(
              onTap: widget.onForgotPassword,
              child: Text(
                'Forgot Password?',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        AppSizes.gap8,
        TextFormField(
          controller: widget.controller,
          obscureText: _obscure,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => widget.onSubmitted?.call(),
          decoration: InputDecoration(
            hintText: 'Enter password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: GestureDetector(
              onTap: () => setState(() => _obscure = !_obscure),
              child: Icon(
                _obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
      ],
    );
  }
}
