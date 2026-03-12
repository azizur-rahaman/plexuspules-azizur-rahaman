import 'package:flutter/material.dart';
import 'package:plexuspules/core/constants/app_sizes.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final double? elevation;
  final Color? backgroundColor;

  const CommonAppBar({
    super.key,
    this.title,
    this.centerTitle = true,
    this.actions,
    this.leading,
    this.elevation = 0,
    this.backgroundColor,
  });

  /// Factory constructor for the Brand Identity AppBar used in Dashboard
  factory CommonAppBar.brand({Key? key}) {
    return CommonAppBar(
      key: key,
      title: Image.asset(
        'assets/brand-logo-icon.png',
        height: AppSizes.p32,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: centerTitle,
      actions: actions,
      leading: leading,
      elevation: elevation,
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
