import 'package:courier_delivery_app/domain/parcel/model/top_level_rider_parcel_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';
import 'widgets/rider_categorized_delivery_list.dart';

class DeliveryScreen extends HookConsumerWidget {
  const DeliveryScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    final tabController =
        useTabController(initialLength: ParcelRiderType.values.length);
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          centerTitle: true,
          title: AppStrings.deliverDashboard.text.bold.white.xl.make(),
          backgroundColor: context.colors.primary,
          floating: true,
          pinned: true,
        ),
        SliverPersistentHeader(
          floating: true,
          delegate: TotalDeliverySection(),
        ),
        SliverPersistentHeader(
          delegate: DeliveryTabSection(tabController: tabController),
          floating: true,
        ),
        // SliverToBoxAdapter(
        //   child: Container(
        //     height: 60.h,
        //     color: context.colors.primary,
        //     child: Row(
        //       mainAxisAlignment: mainSpaceBetween,
        //       children: [
        //         AppStrings.totalPendingOrders.text.semiBold.white.make(),
        //         "3".text.white.bold.make(),
        //       ],
        //     )
        //         .pSymmetric(h: 18, v: 10)
        //         .box
        //         .width(.85.sw)
        //         .color(context.colors.primaryContainer.lighten())
        //         .roundedLg
        //         .makeCentered(),
        //   ),
        // ),
        // SliverToBoxAdapter(
        //   child: Container(
        //     height: 60.h,
        //     width: 1.sw,
        //     color: context.colors.primary,
        //     // padding: paddingBottom4,
        //     child: TabBar(
        //       controller: tabController,
        //       labelColor: ColorPalate.bg100,
        //       labelStyle: TextStyle(
        //         fontSize: 16.sp,
        //         fontWeight: FontWeight.bold,
        //       ),
        //       unselectedLabelColor: ColorPalate.bg200,
        //       unselectedLabelStyle: TextStyle(
        //         fontSize: 16.sp,
        //         fontWeight: FontWeight.w500,
        //       ),
        //       indicatorPadding: paddingBottom4,
        //       indicator: BoxDecoration(
        //         border: Border(
        //           bottom: BorderSide(
        //             width: 3.5.h,
        //             color: Colors.white,
        //           ),
        //         ),
        //         // borderRadius: BorderRadius.circular(2.r),
        //       ),
        //       indicatorWeight: 3,
        //       indicatorSize: TabBarIndicatorSize.tab,
        //       indicatorColor: context.colors.primary,
        //       dividerColor: context.colors.primary,
        //       tabs: DeliveryTabs.values
        //           .map(
        //             (e) => Tab(
        //               text: e.name.toCapitalize(),
        //             ),
        //           )
        //           .toList(),
        //     ),
        //   ),
        // ),
        SliverFillRemaining(
          child: TabBarView(
            controller: tabController,
            children: ParcelRiderType.values
                .map((e) => RiderCategorizedDeliveryList(type: e))
                .toList(),
          ),
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

class DeliveryTabSection extends SliverPersistentHeaderDelegate {
  DeliveryTabSection({
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return TabBar(
      controller: tabController,
      padding: padding0,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 12.sp,
        letterSpacing: 1,
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
        letterSpacing: .9,
      ),
      unselectedLabelColor: ColorPalate.white,
      // isScrollable: true,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(
          25.0,
        ),
        color: ColorPalate.white,
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: EdgeInsets.symmetric(vertical: 4.w),
      tabs: ParcelRiderType.values
          .map((e) => Tab(
                text: e.name.toCapitalize(),
                iconMargin: const EdgeInsets.only(
                  bottom: 10.0,
                  left: 10,
                  right: 10,
                ),
              ))
          .toList(),
    ).box.color(context.colors.primary).height(60.h).make();
  }

  @override
  double get maxExtent => 60.h;

  @override
  double get minExtent => 60.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
