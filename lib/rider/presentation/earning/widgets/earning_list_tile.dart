import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../utils/utils.dart';

class EarningListTile extends StatelessWidget {
  const EarningListTile({
    Key? key,
    required this.name,
    required this.orderId,
    required this.amount,
  }) : super(key: key);

  final String name;
  final String orderId;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 54.h,
          margin: paddingV2,
          decoration: BoxDecoration(
            color: context.colors.secondary,
            borderRadius: BorderRadius.all(
              Radius.circular(6.r),
            ),
          ),
        ),
        gap24,
        Column(
          crossAxisAlignment: crossStart,
          mainAxisAlignment: mainSpaceBetween,
          mainAxisSize: mainMax,
          children: [
            name.text.lg.semiBold.make(),
            gap4,
            "Order $orderId".text.caption(context).make(),
          ],
        ),
        "${AppStrings.tk}$amount"
            .text
            .xl2
            .make()
            .objectCenterRight()
            .flexible(),
        gap28,
      ],
    ).box.roundedSM.border(color: AppColors.bg300).white.make().px(16);
  }
}
