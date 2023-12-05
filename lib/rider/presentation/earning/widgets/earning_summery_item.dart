import 'package:courier_delivery_app/utils/box_shadow/box_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../utils/utils.dart';

class SummerSection extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Positioned(
          top: -2,
          left: 0,
          right: 0,
          child: VxArc(
            height: 60.h,
            child: Container(
              color: AppColors.primary,
              height: 80,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 32.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 14.w,
              mainAxisSpacing: 8.h,
              childAspectRatio: 1.2,
            ),
            children: const [
              SummaryItem(
                count: '${AppStrings.tk}10367',
                title: AppStrings.monthlyEarings,
              ),
              SummaryItem(
                count: '${AppStrings.tk}600',
                title: AppStrings.dailyEarings,
              ),
              SummaryItem(
                count: '6',
                title: AppStrings.dailyOrders,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 136.w;

  @override
  double get minExtent => 136.w;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class SummaryItem extends StatelessWidget {
  const SummaryItem({
    super.key,
    required this.count,
    required this.title,
  });
  final String count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.h, bottom: 8.h, left: 8.w, right: 8.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16.r),
        ),
        boxShadow: DefineBoxShadow.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: crossCenter,
        mainAxisAlignment: mainSpaceAround,
        children: [
          count.text.bold.xl.gray600.make(),
          title.text.sm.heightRelaxed.center.bold.gray400.make(),
        ],
      ),
    );
  }
}
