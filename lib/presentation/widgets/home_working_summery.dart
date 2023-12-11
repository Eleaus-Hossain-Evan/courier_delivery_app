import 'package:courier_delivery_app/application/dashboard/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';

class HomeWorkingSummery extends HookConsumerWidget {
  const HomeWorkingSummery({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final asyncDashboard = ref.watch(dashboardProvider);

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: asyncDashboard.when(
        data: (data) {
          // return const WorkingSummeryItemShimmer();
          return GridView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 1.6.w,
            ),
            children: [
              WorkingSummeryItem(
                icon: Icons.access_time_filled,
                title: AppStrings.pendingDelivery,
                count: data.tAssign,
                textColor: AppColors.secondary200,
                bgColor: AppColors.secondary,
              ),
              WorkingSummeryItem(
                icon: Icons.delivery_dining,
                title: AppStrings.cancelDelivery,
                count: data.tReject,
                textColor: context.colors.error,
                bgColor: context.colors.error,
              ),
              WorkingSummeryItem(
                icon: Icons.check_circle,
                title: AppStrings.completedDelivery,
                count: data.tComplete,
                textColor: AppColors.primary200,
                bgColor: AppColors.primary,
              ),
              const WorkingSummeryItem(
                icon: Icons.stop_circle_outlined,
                title: AppStrings.holdDelivery,
                count: 11,
                textColor: AppColors.blue,
                bgColor: AppColors.crystalBlue,
              ),
            ],
          );
        },
        error: (error, stackTrace) => error.toString().text.make(),
        loading: () => const WorkingSummeryItemShimmer(),
      ),
    );
  }
}

class WorkingSummeryItem extends StatelessWidget {
  const WorkingSummeryItem({
    super.key,
    required this.icon,
    required this.title,
    required this.count,
    required this.textColor,
    required this.bgColor,
  });

  final IconData icon;
  final String title;
  final int count;
  final Color textColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainSpaceBetween,
      crossAxisAlignment: crossStart,
      children: [
        Icon(
          icon,
          color: textColor,
        ).px12(),
        count.text.xl2.bold.color(textColor).make().px12(),
        title.text.isIntrinsic
            .textStyle(TextStyle(fontSize: 14.sp))
            .wide
            .bold
            .color(textColor)
            .make()
            .pOnly(left: 8),
      ],
    )
        .py12()
        .box
        .color(bgColor.withOpacity(.3))
        .roundedSM
        .make()
        .box
        .white
        .roundedSM
        .shadowSm
        .make();
  }
}

class WorkingSummeryItemShimmer extends StatelessWidget {
  const WorkingSummeryItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: GridView.builder(
        // spacing: 16.w,
        // runSpacing: 16.h,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 1.6.w,
        ),
        itemBuilder: (context, index) {
          return VxBox(child: SizedBox(height: 110.h))
              .colorScaffoldBackground(context)
              .roundedSM
              .width(.28.sw)
              .make();
        },
        itemCount: 4,
      ),
    );
  }
}
