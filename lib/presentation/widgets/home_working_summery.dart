import 'package:courier_delivery_app/application/auth/auth_provider.dart';
import 'package:courier_delivery_app/application/dashboard/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
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

    return asyncDashboard
        .when(
          data: (data) {
            return SizedBox(
              height: 240.h,
              child: GridView(
                // spacing: 16.w,
                // runSpacing: 16.h,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 1.6,
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
              ),
            );
          },
          error: (error, stackTrace) => error.toString().text.make(),
          loading: () => const WorkingSummeryItemShimmer(),
        )
        .p(16.w);
  }
}

class WorkingSummeryItemShimmer extends StatelessWidget {
  const WorkingSummeryItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: SizedBox(
        height: 240.h,
        child: GridView.builder(
          // spacing: 16.w,
          // runSpacing: 16.h,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
            childAspectRatio: 1.6,
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
      mainAxisAlignment: mainCenter,
      crossAxisAlignment: crossStart,
      children: [
        gap12,
        Icon(
          icon,
          color: textColor,
        ).px12(),
        gap6,
        count.text.xl2.bold.color(textColor).make().px12(),
        gap2,
        title.text.wide.bold.color(textColor).make().px8(),
        gap12,
      ],
    )
        .box
        .color(bgColor.withOpacity(.3))
        .roundedSM
        .make()
        .box
        .width(.42.sw)
        .white
        .roundedSM
        .shadowSm
        .make();
  }
}
