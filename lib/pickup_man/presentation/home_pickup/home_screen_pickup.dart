import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:courier_delivery_app/pickup_man/application/parcel_pickup/parcel_pickup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shimmer/shimmer.dart';

import '../../../presentation/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../widgets/parcel_pickup_list_tile.dart';
import 'widgets/home_app_bar.dart';

const pageSize = 2;

class HomeScreenPickup extends HookConsumerWidget {
  static String route = "/home-pickup";
  const HomeScreenPickup({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final refreshController = useMemoized(
        () => RefreshController(initialLoadStatus: LoadStatus.canLoading));
    final state = ref.watch(parcelPickupProvider);
    final currentType = useState(ParcelPickupStatus.all);

    final page = useState(1);
    final totalPage = useState(0);

    ref.listen(parcelPickupProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        BotToast.showLoading();
      }
      if (previous.loading == true && next.loading == false) {
        BotToast.closeAllLoading();
      }
      totalPage.value = next.parcelPickupResponse.metaData.totalPage;
    });

    void pagination() {
      // if (scrollController.position.maxScrollExtent <=
      //     scrollController.position.pixels + 10.sh) {
      //   log("${page.value} < ${totalPage.value}");
      //   if (page.value < totalPage.value) {
      //     // easyController.callLoad();
      //     page.value = page.value + 1;
      //     ref
      //         .read(parcelPickupProvider.notifier)
      //         .parcelPickupList(page: page.value, limit: pageSize);
      //   }
      // }
    }

    useEffect(() {
      Future.microtask(
          () => ref.read(parcelPickupProvider.notifier).parcelPickupList(
                page: page.value,
                limit: pageSize,
                type: currentType.value,
              ));

      scrollController.addListener(pagination);
      return () {
        scrollController.removeListener(pagination);
        BotToast.closeAllLoading();
      };
    }, []);

    return Scaffold(
      appBar: const HomeAppBar(),
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: true,
          // header: const MaterialHeader(),
          onRefresh: () async {
            page.value = 1;
            // state.copyWith(parcelPickupResponse: ParcelListResponse.init());
            return ref
                .refresh(parcelPickupProvider.notifier)
                .parcelPickupList(
                  page: page.value,
                  limit: pageSize,
                  type: currentType.value,
                )
                .then((value) {
              // return value ? IndicatorResult.success : IndicatorResult.fail;
              refreshController.refreshCompleted(resetFooterState: true);
            });
          },
          onLoading: () async {
            if (state.parcelPickupResponse.data.isNotEmpty) {
              refreshController.loadComplete();
            }
            if (totalPage.value == 0 || page.value == totalPage.value) {
              // return IndicatorResult.noMore;
              refreshController.loadNoData();
            }
            if (page.value < totalPage.value) {
              // easyController.callLoad(
              //   scrollController: scrollController,
              //   force: true,
              // );
              page.value = page.value + 1;
              final success = await ref
                  .read(parcelPickupProvider.notifier)
                  .parcelPickupList(
                    page: page.value,
                    limit: pageSize,
                    type: currentType.value,
                  );
              if (success) {
                // return IndicatorResult.success;
                refreshController.loadComplete();
              } else {
                // return IndicatorResult.fail;
                refreshController.loadFailed();
              }
            }
          },
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: crossStart,
              children: [
                const HomeWorkingSummery(),
                const HomeSearchDelivery(),
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
                    SizedBox(
                      width: .4.sw,
                      child: KDropDownSearchWidget(
                        hintText: 'Status',
                        items: ParcelPickupStatus.values,
                        selectedItem: currentType.value,
                        compareFn: (p0, p1) => p0.name == p1.name,
                        itemAsString: (p0) => p0.name.capitalized,
                        containerMargin: padding0,
                        onChanged: (p0) async {
                          currentType.value = p0!;

                          page.value = 1;
                          ref
                              .refresh(parcelPickupProvider.notifier)
                              .parcelPickupList(
                                page: page.value,
                                limit: pageSize,
                                type: currentType.value,
                              )
                              .then((success) {
                            log('success: $success');
                            // refreshController.resetNoData();
                            refreshController.refreshCompleted(
                                resetFooterState: true);
                            // if (success) {
                            //   // return IndicatorResult.success;
                            //   refreshController.loadComplete();
                            // } else {
                            //   // return IndicatorResult.fail;
                            //   refreshController.loadFailed();
                            // }
                          });

                          // easyController.finishRefresh(IndicatorResult.none);

                          // refreshController.footerMode =
                          //     RefreshNotifier(LoadStatus.canLoading);
                        },
                      ),
                    ),
                  ],
                ).px16(),
                gap24,
                Container(
                  margin: paddingH16.copyWith(top: 16.h),
                  decoration: state.parcelPickupResponse.data.isEmpty
                      ? null
                      : BoxDecoration(
                          color: ColorPalate.white,
                          borderRadius: BorderRadius.circular(7.5.r),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0.0, 3.0),
                                blurRadius: 1.0,
                                spreadRadius: -2.0,
                                color: ColorPalate.kKeyUmbraOpacity),
                            BoxShadow(
                                offset: Offset(0.0, 2.0),
                                blurRadius: 2.0,
                                color: ColorPalate.kKeyPenumbraOpacity),
                            BoxShadow(
                                offset: Offset(0.0, 1.0),
                                blurRadius: 5.0,
                                color: ColorPalate.kAmbientShadowOpacity),
                          ],
                        ),
                  child: KListViewSeparated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gap: 0,
                    padding: padding0,
                    separator: const Divider(),
                    itemBuilder: (context, index) {
                      final parcel = state.parcelPickupResponse.data[index];

                      return ParcelPickupListTile(
                        // index: index,
                        model: parcel,
                        onTapReceive: (note) async {
                          return await ref
                              .read(parcelPickupProvider.notifier)
                              .receivedParcel(parcel.id,
                                  note: note,
                                  shouldRemove: currentType.value ==
                                      ParcelPickupStatus.cancel);
                        },
                        onTapCancel: (note) async {
                          return await ref
                              .read(parcelPickupProvider.notifier)
                              .cancelParcel(parcel.id,
                                  note: note,
                                  shouldRemove: currentType.value ==
                                      ParcelPickupStatus.received);
                        },
                      );
                    },
                    itemCount: state.parcelPickupResponse.data.length,
                  ),
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
