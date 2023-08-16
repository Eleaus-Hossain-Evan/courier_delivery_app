import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';

class HistoryScreen extends HookConsumerWidget {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          centerTitle: true,
          title: AppStrings.pickupHistory.text.bold.white.xl.make(),
          backgroundColor: context.colors.primary,
          floating: true,
          pinned: true,
        ),
        SliverPersistentHeader(
          delegate: TotalDeliverySection(),
        ),
        SliverList(
          delegate: SliverChildListDelegate([]),
        )
      ],
    );
  }
}

class TotalDeliverySection extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Row(
      mainAxisAlignment: mainSpaceBetween,
      children: [
        AppStrings.totalPendingOrders.text.semiBold.white.make(),
        "3".text.white.bold.make(),
      ],
    )
        .pSymmetric(h: 18, v: 10)
        .box
        .width(.85.sw)
        .color(context.colors.primaryContainer.lighten())
        .roundedLg
        .makeCentered()
        .box
        .color(context.colors.primary)
        .make();
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
