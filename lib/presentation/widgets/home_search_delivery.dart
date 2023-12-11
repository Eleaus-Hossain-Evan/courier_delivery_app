import 'package:courier_delivery_app/rider/presentation/home/widgets/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';
import 'widgets.dart';

class HomeSearchDelivery extends HookConsumerWidget {
  const HomeSearchDelivery({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final searchTextController = useTextEditingController();
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        "Track your package".text.xl.extraBold.make(),
        gap12,
        "Please enter your tracking number".text.caption(context).make(),
        gap14,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: TextFormField(
                controller: searchTextController,
                decoration: InputDecoration(
                  hintText: AppStrings.trackingNumber,
                  hintStyle: CustomTextStyle.textStyle14w500B800.copyWith(
                    color: AppColors.black600,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.w,
                    ),
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  fillColor: AppColors.white,
                  // prefixIcon: Icon(
                  //   Bootstrap.box_seam,
                  //   size: 18.sp,
                  // ),
                  prefixIcon: Image.asset(
                    Images.deliveryBoxList,
                    height: 6.w,
                    width: 6.w,
                    fit: BoxFit.fitHeight,
                  ).pOnly(left: 4.w, right: 4.w),
                ),
              ),
            ),
            gap16,
            SizedBox(
              width: 68.w,
              height: 48,
              child: KFilledButton(
                onPressed: () {
                  context.push(ScanScreen.route);
                },
                // size: Size(60, 50.h),
                padding: padding0,
                backgroundColor: AppColors.primary.lighten(),
                child: const Icon(
                  Icons.qr_code_scanner,
                  color: AppColors.bg200,
                ),
              ),
            ),
          ],
        ),
      ],
    )
        .p16()
        .box
        .rounded
        .color(context.colors.primary.withOpacity(.1))
        .make()
        .px16();
  }
}
