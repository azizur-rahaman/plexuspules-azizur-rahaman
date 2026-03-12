import 'package:flutter/material.dart';
import 'package:plexuspules/core/constants/app_sizes.dart';


class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final double? elevation;
  final Color? backgroundColor;
  final bool showBottomBorder;

  const CommonAppBar({
    super.key,
    this.title,
    this.centerTitle = true,
    this.actions,
    this.leading,
    this.elevation = 0,
    this.backgroundColor,
    this.showBottomBorder = true,
  });

  /// Factory constructor for the Brand Identity AppBar used in Dashboard
  factory CommonAppBar.brand({Key? key, bool showBottomBorder = true}) {
    return CommonAppBar(
      key: key,
      showBottomBorder: showBottomBorder,
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
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      shape: showBottomBorder
          ? Border(
              bottom: BorderSide(
                color: Theme.of(
                  context,
                ).colorScheme.outlineVariant.withValues(alpha: 0.5),
                width: 1,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
