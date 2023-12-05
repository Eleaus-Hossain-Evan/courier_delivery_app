import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../utils/utils.dart';

class EarningListTile extends StatelessWidget {
  const EarningListTile({
    super.key,
    required this.name,
    required this.orderId,
    required this.amount,
  });

  final String name;
  final String orderId;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: paddingH16,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(6.r),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 4.w,
            height: 54.w,
            margin: paddingV2,
            decoration: BoxDecoration(
              color: context.colors.secondary,
              borderRadius: BorderRadius.all(
                Radius.circular(6.r),
              ),
            ),
          ),
          gap24,
          Expanded(
            child: SizedBox(
              height: 54,
              child: Column(
                crossAxisAlignment: crossStart,
                mainAxisAlignment: mainSpaceAround,
                mainAxisSize: mainMax,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Date: ${orderId.toFormatDividerDate()}",
                    style: context.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          Text(
            "${AppStrings.tk}$amount",
            style: context.titleMedium!.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          gap28,
        ],
      ),
    );
  }
}
