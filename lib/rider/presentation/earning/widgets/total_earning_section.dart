import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../utils/utils.dart';

class TotalEarningSection extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ColoredBox(
      color: AppColors.primary,
      child: Center(
        child: Column(
          children: [
            Container(
              width: .85.sw,
              // alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary.lighten(15),
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.w),
              child: Row(
                mainAxisAlignment: mainSpaceBetween,
                children: [
                  AppStrings.totalEarnings.text.semiBold.white.make(),
                  "${AppStrings.tkSymbol} 4321".text.white.bold.make(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
