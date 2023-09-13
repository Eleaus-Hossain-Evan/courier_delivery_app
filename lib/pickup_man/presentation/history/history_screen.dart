import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../presentation/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../../application/parcel_pickup/parcel_pickup_provider.dart';
import '../widgets/parcel_pickup_list_tile.dart';

class HistoryScreen extends HookConsumerWidget {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(parcelPickupProvider);

    final page = useState(1);
    final totalPage = useState(0);
    final count = useState(0);

    final refreshController = useMemoized(() => RefreshController());

    ref.listen(parcelPickupProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        BotToast.showLoading();
      }
      if (previous.loading == true && next.loading == false) {
        BotToast.closeAllLoading();
      }
      totalPage.value = next.parcelPickupResponse.metaData.totalPage;
      count.value = next.parcelPickupResponse.data.length;
    });

    useEffect(() {
      Future.wait([
        Future.microtask(() => ref.invalidate(parcelPickupProvider)),
        Future.microtask(
            () => ref.read(parcelPickupProvider.notifier).parcelPickupList(
                  page: page.value,
                  limit: 10,
                  type: ParcelPickupStatus.all,
                  isComplete: true,
                )),
      ]);

      return () {
        BotToast.closeAllLoading();
        Future.microtask(() => ref.invalidate(parcelPickupProvider));
      };
    }, []);

    return SizedBox(
      height: 1.sh,
      width: 1.sw,
      child: SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: () async {
          page.value = 1;
          return ref
              .read(parcelPickupProvider.notifier)
              .parcelPickupList(
                page: page.value,
                limit: 10,
                type: ParcelPickupStatus.all,
                isComplete: true,
              )
              .then((_) {
            refreshController.refreshCompleted(resetFooterState: true);
          });
        },
        onLoading: () async {
          if (page.value == totalPage.value) {
            // return IndicatorResult.noMore;
            refreshController.loadNoData();
          }
          if (page.value < totalPage.value) {
            page.value = page.value + 1;

            await ref
                .read(parcelPickupProvider.notifier)
                .parcelPickupList(
                  page: page.value,
                  limit: 10,
                  type: ParcelPickupStatus.all,
                  isComplete: true,
                )
                .then((value) => value
                    ? refreshController.loadComplete()
                    : refreshController.loadFailed());
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              title: AppStrings.pickupHistory.text.bold.white.xl.make(),
              backgroundColor: context.colors.primary,
              floating: true,
              pinned: true,
            ),
            SliverPersistentHeader(
              delegate: TotalDeliverySection(
                totalDelivery: count.value,
              ),
            ),
            SliverGap(16.h),
            SliverToBoxAdapter(
              child: Container(
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
                child: Column(
                  children: [
                    count.toString().text.make(),
                    KListViewSeparated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gap: 0,
                      padding: padding0,
                      separator: const Divider(),
                      itemBuilder: (context, index) {
                        return ParcelPickupListTile(
                          // index: index,
                          model: state.parcelPickupResponse.data[index],
                          onTapReceive: (note) => null,
                          onTapCancel: (note) => null,
                        );
                      },
                      itemCount: state.parcelPickupResponse.data.length,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TotalDeliverySection extends SliverPersistentHeaderDelegate {
  final int totalDelivery;

  TotalDeliverySection({required this.totalDelivery});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Row(
      mainAxisAlignment: mainSpaceBetween,
      children: [
        "Total Confirmed Pickup".text.semiBold.white.make(),
        totalDelivery.text.white.bold.make(),
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
      true;
}
