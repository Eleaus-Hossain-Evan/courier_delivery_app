import 'package:bot_toast/bot_toast.dart';
import 'package:courier_delivery_app/pickup_man/application/parcel_pickup/parcel_pickup_provider.dart';
import 'package:courier_delivery_app/pickup_man/domain/parcel/parcel_list_response.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shimmer/shimmer.dart';

import '../../../application/home/home_provider.dart';
import '../../../presentation/widgets/widgets.dart';
import '../../../utils/utils.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/search_delivery.dart';
import 'widgets/working_summery.dart';

const searchPageSize = 10;

class HomeScreenPickup extends HookConsumerWidget {
  static String route = "/home-pickup";
  const HomeScreenPickup({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    final page = useState(1);

    final parcelResponse = ref.watch(parcelPickupProvider(page: page.value));

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
        child: EasyRefresh(
          header: const MaterialHeader(),
          onRefresh: () async {
            page.value = 1;
            ref.refresh(parcelPickupProvider().future).then((value) =>
                value == ParcelListResponse.init()
                    ? IndicatorResult.fail
                    : IndicatorResult.success);
          },
          onLoad: () {
            page.value++;
            ref.read(parcelPickupProvider(page: page.value).future).then(
                (value) => value == ParcelListResponse.init()
                    ? IndicatorResult.fail
                    : IndicatorResult.success);
          },
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: crossStart,
              children: [
                const WorkingSummery(),
                const SearchDelivery(),
                gap12,
                Row(
                  mainAxisAlignment: mainSpaceBetween,
                  children: [
                    AppStrings.recentDelivery.text.bold.lg
                        .color(ColorPalate.black900)
                        .make(),
                    // AppStrings.viewAll.text
                    //     .color(ColorPalate.secondary200)
                    //     .make()
                    //     .pSymmetric(h: 4, v: 2)
                    //     .onInkTap(() {
                    //   final navigatorKey =
                    //       bottomNavigatorKeyPickup.currentWidget as NavigationBar;

                    //   navigatorKey.onDestinationSelected!(1);
                    // })
                  ],
                ).px16(),
                gap24,
                parcelResponse.when(
                  data: (data) {
                    return KListViewSeparated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gap: 0,
                      padding: padding0,
                      itemBuilder: (context, index) {
                        final parcel = data[index];
                        return DeliveryListTile.loading(
                          customerName: parcel.parcel.merchantInfo.name,
                          address: parcel.parcel.merchantInfo.address,
                          distance: "",
                        );
                      },
                      itemCount: data.length,
                    );
                  },
                  error: (error, stackTrace) => Center(
                    child: error.toString().text.caption(context).make(),
                  ),
                  loading: () =>
                      const CircularProgressIndicator().objectBottomCenter(),
                ),
              ],
            ),
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
