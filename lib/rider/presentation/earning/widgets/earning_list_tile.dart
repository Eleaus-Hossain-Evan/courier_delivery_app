import 'package:courier_delivery_app/presentation/widgets/k_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../utils/utils.dart';
import '../earning_detail_screen.dart';

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
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: KInkWell(
        onTap: () {
          context.push("${EarningDetailScreen.route}/65310b6c19d4f09d1edf6fa0");
        },
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
              "${AppStrings.tkSymbol}$amount",
              style: context.titleMedium!.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            gap28,
          ],
        ),
      ),
    );
  }
}
