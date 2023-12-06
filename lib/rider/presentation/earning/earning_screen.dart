import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';
import 'widgets/earning_list_tile.dart';
import 'widgets/earning_summery_item.dart';
import 'widgets/total_earning_section.dart';

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
            title: const Text(AppStrings.myEarnings),
            titleTextStyle: context.textTheme.titleMedium!.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
            backgroundColor: context.colors.primary,
            toolbarHeight: 42.h,
            pinned: true,
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: TotalEarningSection(),
          ),
          SliverPersistentHeader(
            // floating: true,
            delegate: SummerSection(),
          ),
          // const SummerSection().toSliverBox(),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverList.separated(
              itemBuilder: (context, index) => EarningListTile(
                name: "Samsul Alom",
                orderId: DateTime.now().toString(),
                amount: '7',
              ),
              itemCount: 15,
              separatorBuilder: (context, index) => const HeightBox(16),
            ),
          ),
        ],
      ),
    );
  }
}
