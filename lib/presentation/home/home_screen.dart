import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../application/home/home_provider.dart';
import '../../utils/utils.dart';
import '../main_nav/main_nav.dart';
import '../widgets/widgets.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/search_delivery.dart';
import 'widgets/working_summery.dart';

class HomeScreenRider extends HookConsumerWidget {
  static String route = "/home-rider";
  const HomeScreenRider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    ref.listen(homeProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        BotToast.showLoading();
      }
      if (previous.loading == true && next.loading == false) {
        BotToast.closeAllLoading();
      }
    });

    return Scaffold(
      appBar: const HomeAppBar(),
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              const WorkingSummery(),
              const SearchDelivery(),
              gap12,
              Column(
                children: [
                  Row(
                    mainAxisAlignment: mainSpaceBetween,
                    children: [
                      AppStrings.todayDelivery.text.bold.lg
                          .color(ColorPalate.black900)
                          .make(),
                      AppStrings.viewAll.text
                          .color(ColorPalate.secondary200)
                          .make()
                          .pSymmetric(h: 4, v: 2)
                          .onInkTap(() {
                        final navigatorKey =
                            bottomNavigatorKey.currentWidget as NavigationBar;

                        navigatorKey.onDestinationSelected!(1);
                      })
                    ],
                  ),
                  gap24,
                  KListViewSeparated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gap: 16,
                    padding: padding0,
                    itemBuilder: (context, index) {
                      return const DeliveryListTile(
                        customerName: "Evan Hossain",
                        address:
                            "169/B, North Konipara, Tejgoan, Dhaka, Bangladesh",
                        distance: "3 kms",
                      );
                    },
                    itemCount: 10,
                  ),
                ],
              )
                  .p(16.w)
                  .box
                  .color(ColorPalate.bg100)
                  .topRounded()
                  .roundedLg
                  .shadow
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
