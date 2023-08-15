import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../utils/utils.dart';
import '../../../../widgets/widgets.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    Key? key,
    required this.title,
    this.leading,
    this.visible = true,
    required this.child,
    this.replacement,
    this.containerPadding,
  }) : super(key: key);

  final String title;
  final Widget? leading;
  final bool visible;
  final Widget child;
  final Widget? replacement;
  final EdgeInsetsGeometry? containerPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            leading?.pOnly(right: 12.w, left: 8.w) ?? const SizedBox.shrink(),
            title.text.lg.make().objectCenterLeft(),
          ],
        ),
        gap8,
        ContainerBGWhite(
          padding: containerPadding,
          child: Visibility(
            visible: visible,
            replacement: replacement ?? const SizedBox.shrink(),
            child: child,
          ),
        ),
        gap24,
      ],
    ).box.color(ColorPalate.bg200).make();
  }
}
