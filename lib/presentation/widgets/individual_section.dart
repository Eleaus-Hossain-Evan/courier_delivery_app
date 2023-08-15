import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';
import 'widgets.dart';

class IndividualSection extends StatelessWidget {
  const IndividualSection({
    Key? key,
    required this.title,
    this.leading,
    this.visible = true,
    required this.child,
    this.replacement,
    this.containerPadding,
    this.action,
  }) : super(key: key);

  final String title;
  final Widget? leading, action;
  final bool visible;
  final Widget child;
  final Widget? replacement;
  final EdgeInsetsGeometry? containerPadding;

  @override
  Widget build(BuildContext context) {
    return ContainerBGWhite(
      padding: containerPadding,
      child: Column(
        children: [
          Row(
            children: [
              leading?.pOnly(right: 12.w, left: 8.w) ?? const SizedBox.shrink(),
              title.text.bold.lg.make().objectCenterLeft().flexible(),
              action ?? const SizedBox.shrink()
            ],
          ),
          gap16,
          child,
        ],
      ),
    ).box.color(ColorPalate.bg200).make();
  }
}
