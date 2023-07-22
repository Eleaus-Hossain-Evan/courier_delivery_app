import 'package:courier_delivery_app/presentation/delivery/widgets/completed_delivery.dart';
import 'package:courier_delivery_app/presentation/widgets/k_list_view_separated.dart';
import 'package:courier_delivery_app/utils/color_palate.dart';
import 'package:courier_delivery_app/utils/extensions/extensions.dart';
import 'package:courier_delivery_app/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';
import 'widgets/pending_delivery.dart';

enum DeliveryTabs { pending, complete }

class DeliveryScreen extends HookConsumerWidget {
  const DeliveryScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController =
        useTabController(initialLength: DeliveryTabs.values.length);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: true,
          title: "Delivery Dashboard".text.bold.white.xl.make(),
          backgroundColor: context.colors.primary,
          floating: false,
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 60.h,
            color: context.colors.primary,
            child: Row(
              mainAxisAlignment: mainSpaceBetween,
              children: [
                "Total Pending Orders".text.semiBold.white.make(),
                "3".text.white.bold.make(),
              ],
            )
                .pSymmetric(h: 18, v: 10)
                .box
                .width(.85.sw)
                .color(context.colors.primaryContainer.lighten())
                .roundedLg
                .makeCentered(),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 60.h,
            width: 1.sw,
            color: context.colors.primary,
            // padding: paddingBottom4,
            child: TabBar(
              controller: tabController,
              labelColor: ColorPalate.bg100,
              labelStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelColor: ColorPalate.bg200,
              unselectedLabelStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              indicatorPadding: paddingBottom4,
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 3.5.h,
                    color: Colors.white,
                  ),
                ),
                // borderRadius: BorderRadius.circular(2.r),
              ),
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: context.colors.primary,
              dividerColor: context.colors.primary,
              tabs: DeliveryTabs.values
                  .map(
                    (e) => Tab(
                      text: e.name.toCapitalize(),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        SliverFillRemaining(
          fillOverscroll: true,
          child: TabBarView(
            controller: tabController,
            children: const [
              PendingDelivery(),
              CompletedDelivery(),
            ],
          ),
        )
      ],
    ).box.color(context.colors.primary).make();
  }
}
