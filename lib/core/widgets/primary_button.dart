import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: AppSizes.p16),
        ),
        child: isLoading
            ? SizedBox(
                height: AppSizes.font16 * 1.5,
                width: AppSizes.font16 * 1.5,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: AppSizes.font16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
