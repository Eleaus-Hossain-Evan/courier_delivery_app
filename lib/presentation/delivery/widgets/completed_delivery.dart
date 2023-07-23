import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class CompletedDelivery extends StatelessWidget {
  const CompletedDelivery({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPalate.bg100,
      child: KListViewSeparated(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        gap: 12,
        separator: HeightBox(16.h),
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: crossStart,
            children: [
              Images.deliveryBox.circularAssetImage(radius: 25.r),
              gap6,
              Flexible(
                child: Column(
                  crossAxisAlignment: crossStart,
                  children: [
                    "Evan Hossain".text.xl.bold.make(),
                    gap4,
                    Row(
                      crossAxisAlignment: crossStart,
                      children: [
                        const Icon(Icons.home_outlined)
                            .iconColor(context.theme.primaryColorDark)
                            .iconSize(16.sp),
                        gap4,
                        "169/B, North Konipara, Tejgoan, Dhaka, Bangladesh"
                            .text
                            .medium
                            .caption(context)
                            .color(ColorPalate.black700)
                            .make()
                            .box
                            .width(.5.sw)
                            .make(),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: mainSpaceBetween,
                mainAxisSize: mainMax,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on)
                          .iconSize(16.sp)
                          .iconColor(context.theme.primaryColorDark),
                      "3 kms".text.caption(context).make(),
                    ],
                  ),
                  gap24,
                  const Icon(Icons.arrow_forward_ios)
                      .iconColor(ColorPalate.secondary200)
                      .iconSize(16.sp),
                ],
              ),
            ],
          )
              .p8()
              .box
              .color(ColorPalate.secondary.lighten().withOpacity(.03))
              .border(
                color: ColorPalate.secondary.lighten().withOpacity(.1),
                width: 1.2.w,
              )
              .roundedSM
              .make();
        },
        itemCount: 10,
      ),
    );
  }
}
