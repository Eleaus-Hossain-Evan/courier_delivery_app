import 'package:bot_toast/bot_toast.dart';
import 'package:courier_delivery_app/pickup_man/application/parcel_pickup/parcel_pickup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shimmer/shimmer.dart';

import '../../../application/home/home_provider.dart';
import '../../../presentation/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../main_nav_pickup/main_nav_pickup.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/search_delivery.dart';
import 'widgets/working_summery.dart';

class HomeScreenPickup extends HookConsumerWidget {
  static String route = "/home-pickup";
  const HomeScreenPickup({super.key});
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
                        final navigatorKey = bottomNavigatorKeyPickup
                            .currentWidget as NavigationBar;

                        navigatorKey.onDestinationSelected!(1);
                      })
                    ],
                  ),
                  gap24,
                  ListView.custom(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: padding0,
                      childrenDelegate: SliverChildBuilderDelegate(
                        (context, index) {
                          const pageSize = 10;

                          final page = index ~/ pageSize + 1;
                          final indexInPage = index % pageSize;
                          final parcelResponse = ref.watch(
                            parcelPickupProvider(
                              type: ParcelPickupType.assign,
                              page: page,
                            ),
                          );

                          return parcelResponse.when(
                            data: (data) {
                              if (indexInPage >= data.length) return null;

                              final parcel = data[indexInPage];
                              return const DeliveryListTile(
                                customerName: "Evan Hossain",
                                address:
                                    "169/B, North Konipara, Tejgoan, Dhaka, Bangladesh",
                                distance: "3 kms",
                              );
                            },
                            error: (err, stack) {
                              Logger.e(err);
                              return Text('Error $err');
                            },
                            loading: () => const PackageItemShimmer(),
                          );
                        },
                      )),
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


class PackageItemShimmer extends StatelessWidget {
  const PackageItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: ListTile(
        title: Builder(
          builder: (context) {
            return Row(
              children: [
                Container(
                  height: DefaultTextStyle.of(context).style.fontSize! * .8,
                  width: 100,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  height: DefaultTextStyle.of(context).style.fontSize! * .8,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        subtitle: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  Container(
                    height: DefaultTextStyle.of(context).style.fontSize! * .8,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: DefaultTextStyle.of(context).style.fontSize! * .8,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}