import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../application/parcel_rider/parcel_rider_provider.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

const Color _kKeyUmbraOpacity = Color(0x33000000); // alpha = 0.2
const Color _kKeyPenumbraOpacity = Color(0x24000000); // alpha = 0.14
const Color _kAmbientShadowOpacity = Color(0x1F000000); // alpha = 0.12

class RiderCategorizedDeliveryList extends HookConsumerWidget {
  const RiderCategorizedDeliveryList({
    Key? key,
    required this.type,
  }) : super(key: key);

  final ParcelRiderType type;

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(parcelRiderProvider);
    // final currentType = useState(ParcelRiderType.all);
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
      Future.wait([
        Future.microtask(() => ref.invalidate(parcelRiderProvider)),
        Future.microtask(
            () => ref.read(parcelRiderProvider.notifier).parcelPickupList(
                  page: page.value,
                  limit: 10,
                  type: type,
                  isComplete: true,
                )),
      ]);

      return () {
        BotToast.closeAllLoading();
      };
    }, []);

    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: () async {
        page.value = 1;

        return ref
            .read(parcelRiderProvider.notifier)
            .parcelPickupList(
              page: 1,
              limit: 10,
              type: type,
              isComplete: false,
            )
            .then((value) {
          refreshController.refreshCompleted(resetFooterState: true);
        });
      },
      onLoading: () async {
        if (page.value == totalPage.value) {
          refreshController.loadNoData();
        }
        if (page.value < totalPage.value) {
          page.value = page.value + 1;

          await ref
              .read(parcelRiderProvider.notifier)
              .parcelPickupList(
                page: page.value,
                limit: 10,
                type: ParcelRiderType.all,
                isComplete: false,
              )
              .then((value) => value
                  ? refreshController.loadComplete()
                  : refreshController.loadFailed());
        }
      },
      child: Container(
        margin: paddingH16.copyWith(top: 16.h),
        decoration: state.parcelRiderResponse.data.isEmpty
            ? null
            : BoxDecoration(
                color: ColorPalate.white,
                borderRadius: BorderRadius.circular(7.5.r),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0.0, 3.0),
                      blurRadius: 1.0,
                      spreadRadius: -2.0,
                      color: _kKeyUmbraOpacity),
                  BoxShadow(
                      offset: Offset(0.0, 2.0),
                      blurRadius: 2.0,
                      color: _kKeyPenumbraOpacity),
                  BoxShadow(
                      offset: Offset(0.0, 1.0),
                      blurRadius: 5.0,
                      color: _kAmbientShadowOpacity),
                ],
              ),
        child: KListViewSeparated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gap: 16,
          padding: padding0,
          separator: const KDivider(color: ColorPalate.bg300),
          itemBuilder: (context, index) {
            // final parcel = state.parcelRiderResponse.data[index];
            return ParcelRiderListTile(
              index: index,
              pageType: type,
              onTapComplete: () async {
                return false;
                // return await ref
                //     .read(parcelRiderProvider.notifier)
                //     .receivedParcel(parcel.id, page.value,
                //         shouldRemove:
                //             currentType.value == ParcelRiderType.complete);
              },
              onTapReject: () async {
                return false;
                // return await ref.read(parcelRiderProvider.notifier).cancelParcel(
                //     parcel.id, page.value,
                //     shouldRemove: currentType.value == ParcelRiderType.reject);
              },
            );
          },
          itemCount: state.parcelRiderResponse.data.length,
        ),
      ),
    );
  }
}
