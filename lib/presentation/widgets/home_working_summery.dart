import 'package:courier_delivery_app/application/auth/auth_provider.dart';
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
    final asyncDashboard =
        ref.watch(dashboardProvider(ref.watch(roleProvider) == Role.pickupman));

    return asyncDashboard
        .when(
          data: (data) => Row(
            mainAxisAlignment: mainSpaceBetween,
            children: [
              WorkingSummeryItem(
                icon: Icons.access_time_filled,
                title: AppStrings.pendingDelivery,
                count: data.tAssign,
                textColor: ColorPalate.secondary200,
                bgColor: ColorPalate.secondary,
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
                textColor: ColorPalate.primary200,
                bgColor: ColorPalate.primary,
              ),
            ],
          ),
          error: (error, stackTrace) => error.toString().text.make(),
          loading: () => const WorkingSummeryItemShimmer(),
        )
        .p(16.w);
  }
}

class WorkingSummeryItem extends StatelessWidget {
  const WorkingSummeryItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.count,
    required this.textColor,
    required this.bgColor,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final int count;
  final Color textColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        gap12,
        Icon(
          icon,
          color: textColor,
        ).px12(),
        gap6,
        count.text.xl2.bold.color(textColor).make().px12(),
        gap2,
        title.text
            .minFontSize(5)
            .maxFontSize(9)
            .bold
            .color(textColor)
            .make()
            .px8(),
        gap12,
      ],
    )
        .box
        .color(bgColor.withOpacity(.3))
        .roundedSM
        .width(.28.sw)
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
      child: Row(
        mainAxisAlignment: mainSpaceBetween,
        children: [
          VxBox(child: SizedBox(height: 110.h))
              .colorScaffoldBackground(context)
              .roundedSM
              .width(.28.sw)
              .make(),
          VxBox(child: SizedBox(height: 110.h))
              .colorScaffoldBackground(context)
              .roundedSM
              .width(.28.sw)
              .make(),
          VxBox(child: SizedBox(height: 110.h))
              .colorScaffoldBackground(context)
              .roundedSM
              .width(.28.sw)
              .make(),
        ],
      ),
    );
  }
}
