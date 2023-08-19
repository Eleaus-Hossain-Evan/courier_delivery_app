import 'package:bot_toast/bot_toast.dart';
import 'package:courier_delivery_app/pickup_man/domain/parcel/model/top_level_pickup_parcel_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../presentation/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../../application/parcel_pickup/parcel_pickup_provider.dart';
import '../widgets/parcel_list_tile.dart';

class HistoryScreen extends HookConsumerWidget {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(parcelPickupProvider);

    final page = useState(1);
    final totalPage = useState(0);

    final refreshController =
        useMemoized(() => RefreshController(initialRefresh: false));

    ref.listen(parcelPickupProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        BotToast.showLoading();
      }
      if (previous.loading == true && next.loading == false) {
        BotToast.closeAllLoading();
      }
      totalPage.value = next.parcelPickupResponse.metaData.totalPage;
    });

    useEffect(() {
      Future.microtask(
          () => ref.read(parcelPickupProvider.notifier).parcelPickupList(
                page: page.value,
                limit: 10,
                type: ParcelPickupType.all,
                isComplete: true,
              ));

      return () {
        BotToast.closeAllLoading();
      };
    }, []);

    return SizedBox(
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
              .read(parcelPickupProvider.notifier)
              .parcelPickupList(
                page: page.value,
                limit: 10,
                type: ParcelPickupType.all,
                isComplete: false,
              )
              .then((value) {
            // return value ? IndicatorResult.success : IndicatorResult.fail;
            refreshController.refreshCompleted(resetFooterState: true);
          });
        },
        onLoading: () async {
          if (page.value == totalPage.value) {
            // return IndicatorResult.noMore;
            refreshController.loadNoData();
          }
          if (page.value < totalPage.value) {
            // easyController.callLoad(
            //   scrollController: scrollController,
            //   force: true,
            // );
            page.value = page.value + 1;
            final success =
                await ref.read(parcelPickupProvider.notifier).parcelPickupList(
                      page: page.value,
                      limit: 10,
                      type: ParcelPickupType.all,
                      isComplete: false,
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
                  totalDelivery: state.parcelPickupResponse.data.length),
            ),
            SliverGap(16.h),
            KListViewSeparated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gap: 0,
              padding: padding0,
              separator: const Divider(),
              itemBuilder: (context, index) {
                return ParcelListTile(
                  index: index,
                  onTapReceive: () => null,
                  onTapCancel: () => null,
                );
              },
              itemCount: state.parcelPickupResponse.data.length,
            )
                .box
                .white
                .roundedSM
                .shadowSm
                .makeCentered()
                .px16()
                .sliverToBoxAdapter(),
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
      false;
}
