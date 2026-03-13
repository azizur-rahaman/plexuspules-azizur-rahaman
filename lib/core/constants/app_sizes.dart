import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizes {
  AppSizes._();

  /// Padding & Margin Dimensions
  static double get p2 => 2.w;
  static double get p4 => 4.w;
  static double get p8 => 8.w;
  static double get p12 => 12.w;
  static double get p16 => 16.w;
  static double get p20 => 20.w;
  static double get p24 => 24.w;
  static double get p32 => 32.w;
  static double get p40 => 40.w;
  static double get p48 => 48.w;
  static double get p64 => 64.w;

  /// Icon Sizes
  static double get iconSmall => 16.w;
  static double get iconMedium => 24.w;
  static double get iconLarge => 32.w;
  static double get iconXLarge => 40.w;
  static double get iconXXLarge => 48.w;
  static double get iconXXXLarge => 56.w;

  /// Typography Sizes
  static double get font10 => 10.sp;
  static double get font12 => 12.sp;
  static double get font14 => 14.sp;
  static double get font16 => 16.sp;
  static double get font18 => 18.sp;
  static double get font20 => 20.sp;
  static double get font24 => 24.sp;
  static double get font28 => 28.sp;
  static double get font32 => 32.sp;
  static double get font40 => 40.sp;
  static double get font48 => 48.sp;

  /// Border Radius
  static double get radiusSmall => 4.r;
  static double get radiusMedium => 8.r;
  static double get radiusLarge => 12.r;
  static double get radiusXLarge => 16.r;
  static double get radiusCircular => 100.r;

  /// specific widget sizes
  static double get splashLogoSize => 150.w;

  /// Spaces (SizedBox)
  static SizedBox get gap4 => SizedBox(height: 4.h, width: 4.w);
  static SizedBox get gap8 => SizedBox(height: 8.h, width: 8.w);
  static SizedBox get gap12 => SizedBox(height: 12.h, width: 12.w);
  static SizedBox get gap16 => SizedBox(height: 16.h, width: 16.w);
  static SizedBox get gap20 => SizedBox(height: 20.h, width: 20.w);
  static SizedBox get gap24 => SizedBox(height: 24.h, width: 24.w);
  static SizedBox get gap32 => SizedBox(height: 32.h, width: 32.w);
  static SizedBox get gap40 => SizedBox(height: 40.h, width: 40.w);
  static SizedBox get gap48 => SizedBox(height: 48.h, width: 48.w);
  static SizedBox get gap64 => SizedBox(height: 64.h, width: 64.w);
}
