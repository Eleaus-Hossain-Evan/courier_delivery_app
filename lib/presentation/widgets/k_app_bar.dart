import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KAppBar({
    Key? key,
    this.leading,
    this.title,
    this.titleText,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.titleTextStyle,
    this.centerTitle = true,
    this.bottom,
    this.backgroundColor,
    this.elevation,
  }) : super(key: key);

  final Widget? leading;
  final Widget? title;
  final String? titleText;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final TextStyle? titleTextStyle;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor ?? Colors.transparent,
      foregroundColor: ColorPalate.black,
      leading: leading,
      title: title ??
          (titleText != null && titleText!.isNotEmpty
              ? Text(
                  titleText!,
                  style: titleTextStyle,
                )
              : null),
      actions: actions,
      bottom: bottom,
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
