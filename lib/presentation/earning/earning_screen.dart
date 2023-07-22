import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';

class EarningScreen extends HookConsumerWidget {
  const EarningScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: "My Earnings".text.bold.white.xl.make(),
        backgroundColor: context.colors.primary,
      ),
      body: Column(
        children: [
          Container(
            height: 60.h,
            color: context.colors.primary,
            child: Row(
              mainAxisAlignment: mainSpaceBetween,
              children: [
                "Total Earnings".text.semiBold.white.make(),
                " ৳ 4321".text.white.bold.make(),
              ],
            )
                .pSymmetric(h: 18, v: 10)
                .box
                .width(.85.sw)
                .color(context.colors.primaryContainer.lighten())
                .roundedLg
                .makeCentered(),
          ),
          Stack(
            children: [
              VxArc(
                height: 60,
                child: Container(
                  color: ColorPalate.primary,
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
                      title: "Daily Orders",
                    ),
                    SummaryItem(
                      count: ' ৳ 600',
                      title: "Daily Earnings",
                    ),
                    SummaryItem(
                      count: ' ৳ 10367',
                      title: "Monthly Earnings",
                    ),
                  ],
                ).pLTRB(12.w, 32.h, 12.w, 16.h),
              ),
            ],
          ).box.height(100).make()
        ],
      ),
    );
  }
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
        count.text.bold.xl.make(),
        title.text.caption(context).xs.make(),
      ],
    )
        .pOnly(top: 16.h, bottom: 8.h, left: 6.w, right: 6.w)
        .box
        .color(ColorPalate.bg200)
        .shadowSm
        .roundedSM
        .width(.29.sw)
        .make();
  }
}
