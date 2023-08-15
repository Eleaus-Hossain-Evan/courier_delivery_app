import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/utils.dart';
import 'animations/animations.dart';

class ContainerBGWhite extends StatelessWidget {
  const ContainerBGWhite({
    Key? key,
    required this.child,
    this.padding,
  }) : super(key: key);

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      intervalStart: 0.6,
      duration: const Duration(milliseconds: 400),
      child: Container(
        padding: padding ?? padding20,
        width: 1.sw,
        // margin: EdgeInsets.only(bottom: 28.h),
        decoration: BoxDecoration(
          color: ColorPalate.bg100,
          borderRadius: BorderRadius.circular(16.r),
          // border: Border.all(
          //   color: ColorPalate.primary.withOpacity(.1),
          //   width: 1.2.w,
          // ),
        ),
        child: FadeAnimation(
          intervalStart: 0.5,
          duration: const Duration(milliseconds: 650),
          child: SlideAnimation(
            begin: const Offset(100, 0),
            intervalStart: 0.5,
            duration: const Duration(milliseconds: 650),
            child: child,
          ),
        ),
      ),
    );
  }
}
