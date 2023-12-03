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
        VxArc(
          height: 60,
          child: Container(
            color: AppColors.primary,
            height: 80,
          ),
        ).positioned(
          top: 0,
          left: 0,
          right: 0,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: mainSpaceAround,
            children: const [
              SummaryItem(
                count: '6',
                title: AppStrings.dailyOrders,
              ),
              SummaryItem(
                count: '${AppStrings.tk} 600',
                title: AppStrings.dailyEarings,
              ),
              SummaryItem(
                count: '${AppStrings.tk} 10367',
                title: AppStrings.monthlyEarings,
              ),
            ],
          ).pLTRB(12.w, 32.h, 12.w, 32.h),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 160;

  @override
  double get minExtent => 160;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class SummaryItem extends StatelessWidget {
  const SummaryItem({
    Key? key,
    required this.count,
    required this.title,
  }) : super(key: key);
  final String count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossCenter,
      children: [
        gap8,
        count.text.bold.xl2.make(),
        gap6,
        title.text.caption(context).center.makeCentered(),
      ],
    )
        .pOnly(top: 16.h, bottom: 8.h, left: 8.w, right: 8.w)
        .box
        .color(AppColors.bg200)
        .shadowSm
        .roundedSM
        .width(.29.sw)
        .make();
  }
}
