---
name: Flutter Theme Usage
description: Guidelines for styling screens and managing colors using the app's theme.
---

# Flutter Theme and Sizes Usage

When designing or modifying any screens in this project, you MUST use `Theme.of(context)` for all styling, rather than hardcoding colors or text styles. Additionally, you MUST use `AppSizes` for all margins, paddings, dimensions, sizes, and spacing.

## Adding New Colors

If a design requires a new color that is not currently available in the application's theme, you must follow these steps in order:

1. **Define the Color**: Add the new color definition to the `AppColors` class located in `lib/config/theme/app_colors.dart`.
2. **Update the Theme**: Integrate the new color into the application's `ThemeData` by updating `lib/config/theme/app_theme.dart`.
3. **Use the Theme**: Finally, apply the newly added color to your UI components using `Theme.of(context)`.

**Never** hardcode colors directly in screen widget files. Always leverage the centralized theme.

## Using App Sizes

If a design requires spacing, paddings, or standard dimensions (like `SizedBox(height: 8)` or `padding: EdgeInsets.all(16)`), you must use constants defined in `AppSizes` from `lib/core/constants/app_sizes.dart`. 
For instance, use `AppSizes.gap8` instead of `SizedBox(height: 8)`, and `AppSizes.p16` instead of `16.0` for padding. If a required size standard is missing, define it inside `AppSizes` first.
