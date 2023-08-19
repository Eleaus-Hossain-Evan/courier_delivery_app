import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../application/parcel_rider/parcel_rider_provider.dart';
import '../../../domain/parcel/model/top_level_rider_parcel_model.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class RiderCategorizedDeliveryList extends HookConsumerWidget {
  const RiderCategorizedDeliveryList({
    Key? key,
    required this.type,
  }) : super(key: key);

  final ParcelRiderType type;

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(parcelRiderProvider);
    final currentType = useState(ParcelRiderType.all);
    final page = useState(1);
    final totalPage = useState(0);

    final refreshController =
        useMemoized(() => RefreshController(initialRefresh: false));

    ref.listen(parcelRiderProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        BotToast.showLoading();
      }
      if (previous.loading == true && next.loading == false) {
        BotToast.closeAllLoading();
      }
      totalPage.value = next.parcelRiderResponse.metaData.totalPage;
    });

    useEffect(() {
      Future.microtask(
          () => ref.read(parcelRiderProvider.notifier).parcelPickupList(
                page: page.value,
                limit: 10,
                type: type,
                isComplete: true,
              ));

      return () {
        BotToast.closeAllLoading();
      };
    }, []);

    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: true,
      // header: const MaterialHeader(),
      onRefresh: () async {
        page.value = 1;
        // state.copyWith(parcelPickupResponse: ParcelListResponse.init());
        return ref
            .read(parcelRiderProvider.notifier)
            .parcelPickupList(
              page: page.value,
              limit: 10,
              type: ParcelRiderType.all,
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
              await ref.read(parcelRiderProvider.notifier).parcelPickupList(
                    page: page.value,
                    limit: 10,
                    type: ParcelRiderType.all,
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
      child: KListViewSeparated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gap: 16,
        padding: padding0,
        separator: const KDivider(color: ColorPalate.bg300),
        itemBuilder: (context, index) {
          final parcel = state.parcelRiderResponse.data[index];
          return ParcelRiderListTile(
            index: index,
            onTapReceive: () async {
              return await ref
                  .read(parcelRiderProvider.notifier)
                  .receivedParcel(
                      parcel.id, page.value,
                      shouldRemove:
                          currentType.value == ParcelRiderType.cancel);
            },
            onTapCancel: () async {
              return await ref.read(parcelRiderProvider.notifier).cancelParcel(
                  parcel.id, page.value,
                  shouldRemove: currentType.value == ParcelRiderType.received);
            },
          );
        },
        itemCount: state.parcelRiderResponse.data.length,
      ).box.white.roundedSM.shadowSm.make().px16().pOnly(top: 16.h),
    );
  }
}
