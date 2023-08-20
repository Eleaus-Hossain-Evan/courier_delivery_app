import 'package:bot_toast/bot_toast.dart';
import 'package:courier_delivery_app/application/parcel_rider/parcel_rider_provider.dart';
import 'package:courier_delivery_app/domain/parcel/model/top_level_rider_parcel_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../utils/utils.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/search_delivery.dart';
import 'widgets/todays_parcel_section.dart';
import 'widgets/working_summery.dart';

const pageSize = 2;

class HomeScreenRider extends HookConsumerWidget {
  static String route = "/home-rider";
  const HomeScreenRider({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    final refreshController = useMemoized(
        () => RefreshController(initialLoadStatus: LoadStatus.canLoading));
    final state = ref.watch(parcelRiderProvider);
    final currentType = useState(ParcelRiderType.all);

    final page = useState(1);
    final totalPage = useState(0);

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
      Future.microtask(() => ref.invalidate(parcelRiderProvider));
      Future.microtask(
          () => ref.read(parcelRiderProvider.notifier).parcelPickupList(
                page: page.value,
                limit: pageSize,
                type: currentType.value,
              ));

      // scrollController.addListener(pagination);
      return () {
        // scrollController.removeListener(pagination);
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
                .refresh(parcelRiderProvider.notifier)
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
            if (state.parcelRiderResponse.data.isNotEmpty) {
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
              final success =
                  await ref.read(parcelRiderProvider.notifier).parcelPickupList(
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
                const WorkingSummery(),
                const SearchDelivery(),
                gap12,
                TodaysParcelSection(
                  state: state,
                  page: page,
                  currentType: currentType,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
