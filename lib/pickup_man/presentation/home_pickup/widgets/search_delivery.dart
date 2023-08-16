import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../presentation/widgets/widgets.dart';
import '../../../../utils/utils.dart';

class SearchDelivery extends HookConsumerWidget {
  const SearchDelivery({super.key});

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
                    color: ColorPalate.black600,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.w,
                    ),
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  fillColor: ColorPalate.bg200,
                  // prefixIcon: Icon(
                  //   Bootstrap.box_seam,
                  //   size: 18.sp,
                  // ),
                  prefixIcon: Image.asset(
                    Images.deliveryBoxList,
                    height: 8.w,
                    width: 8.w,
                    fit: BoxFit.fitHeight,
                  ).pOnly(left: 4.w),
                ),
              ),
            ),
            gap16,
            SizedBox(
              width: 60.w,
              height: 50.h,
              child: KFilledButton(
                onPressed: () {},
                text: '',
                // size: Size(60, 50.h),
                padding: padding0,
                backgroundColor: ColorPalate.primary.lighten(),
                child: const Icon(
                  Icons.qr_code_scanner,
                  color: ColorPalate.bg200,
                ),
              ),
            ),
          ],
        ),
      ],
    ).p16().box.rounded.color(context.colors.primary.withOpacity(.1)).make();
  }
}
