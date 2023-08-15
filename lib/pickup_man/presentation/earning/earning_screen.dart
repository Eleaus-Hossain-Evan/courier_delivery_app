import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';
import 'widgets/earning_list_tile.dart';
import 'widgets/earning_summery_item.dart';

class EarningScreen extends HookConsumerWidget {
  const EarningScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    void scrollListener() {
      // scrollController.
    }

    useEffect(() {
      scrollController.addListener(scrollListener);

      return () => scrollController.removeListener(scrollListener);
    }, []);

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: AppStrings.myEarnings.text.bold.white.xl.make(),
            backgroundColor: context.colors.primary,
            pinned: true,
          ),
          SliverPersistentHeader(
            floating: true,
            delegate: TotalEarningSection(),
          ),
          SliverPersistentHeader(
            // floating: true,
            delegate: SummerSection(),
          ),
          SliverList.separated(
            itemBuilder: (context, index) => const EarningListTile(
              name: "Samsul Alom",
              orderId: "#1446576867862",
              amount: '7',
            ),
            itemCount: 15,
            separatorBuilder: (context, index) => const HeightBox(16),
          ),

          // SliverToBoxAdapter(
          //   child: SingleChildScrollView(
          //     child: Column(
          //       children: [
          //         // Container(
          //         //   height: 60.h,
          //         //   color: context.colors.primary,
          //         //   child: Row(
          //         //     mainAxisAlignment: mainSpaceBetween,
          //         //     children: [
          //         //       AppStrings.totalEarnings.text.semiBold.white.make(),
          //         //       "${AppStrings.tk} 4321".text.white.bold.make(),
          //         //     ],
          //         //   )
          //         //       .pSymmetric(h: 18, v: 10)
          //         //       .box
          //         //       .width(.85.sw)
          //         //       .color(context.colors.primaryContainer.lighten())
          //         //       .roundedLg
          //         //       .makeCentered(),
          //         // ),
          //         // Stack(
          //         //   children: [
          //         //     VxArc(
          //         //       height: 60,
          //         //       child: Container(
          //         //         color: ColorPalate.primary,
          //         //         height: 80,
          //         //       ),
          //         //     ).positioned(
          //         //       top: 0,
          //         //       left: 0,
          //         //       right: 0,
          //         //     ),
          //         //     Positioned(
          //         //       top: 0,
          //         //       left: 0,
          //         //       right: 0,
          //         //       child: Row(
          //         //         mainAxisAlignment: mainSpaceAround,
          //         //         children: const [
          //         //           SummaryItem(
          //         //             count: '6',
          //         //             title: AppStrings.dailyOrders,
          //         //           ),
          //         //           SummaryItem(
          //         //             count: '${AppStrings.tk} 600',
          //         //             title: AppStrings.dailyEarings,
          //         //           ),
          //         //           SummaryItem(
          //         //             count: '${AppStrings.tk} 10367',
          //         //             title: AppStrings.monthlyEarings,
          //         //           ),
          //         //         ],
          //         //       ).pLTRB(12.w, 32.h, 12.w, 16.h),
          //         //     ),
          //         //   ],
          //         // ).box.height(120).white.make(),
          //         KListViewSeparated(
          //           padding: padding16,
          //           physics: const NeverScrollableScrollPhysics(),
          //           shrinkWrap: true,
          //           gap: 12,
          //           itemBuilder: (context, index) {
          //             return const EarningListTile(
          //               name: "Samsul Alom",
          //               orderId: "#1446576867862",
          //               amount: '7',
          //             );
          //           },
          //           itemCount: 15,
          //         ).box.white.make(),
          //       ],
          //     ),
          //   ).box.color(ColorPalate.primary).make(),
          // ),
        ],
      ),
    );
  }
}

class TotalEarningSection extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Row(
      mainAxisAlignment: mainSpaceBetween,
      children: [
        AppStrings.totalEarnings.text.semiBold.white.make(),
        "${AppStrings.tk} 4321".text.white.bold.make(),
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
