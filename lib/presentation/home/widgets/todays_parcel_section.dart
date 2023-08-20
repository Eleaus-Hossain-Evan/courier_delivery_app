import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../application/parcel_rider/parcel_rider_provider.dart';
import '../../../application/parcel_rider/parcel_rider_state.dart';
import '../../../domain/parcel/model/top_level_rider_parcel_model.dart';
import '../../../utils/utils.dart';
import '../../main_nav/main_nav.dart';
import '../../widgets/widgets.dart';

class TodaysParcelSection extends HookConsumerWidget {
  const TodaysParcelSection({
    super.key,
    required this.state,
    required this.page,
    required this.currentType,
  });

  final ParcelRiderState state;
  final ValueNotifier<int> page;
  final ValueNotifier<ParcelRiderType> currentType;

  @override
  Widget build(BuildContext context, ref) {
    return Column(
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
        ).px16(),
        gap16,
        KListViewSeparated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gap: 16,
          padding: padding0,
          separator: const KDivider(color: ColorPalate.bg300),
          itemBuilder: (context, index) {
            final parcel = state.parcelRiderResponse.data[index];
            return ParcelRiderListTile(
              index: index,
              onTapComplete: () async {
                return await ref
                    .read(parcelRiderProvider.notifier)
                    .receivedParcel(parcel.id, page.value,
                        shouldRemove:
                            currentType.value == ParcelRiderType.complete);
              },
              onTapReject: () async {
                return await ref
                    .read(parcelRiderProvider.notifier)
                    .cancelParcel(parcel.id, page.value,
                        shouldRemove:
                            currentType.value == ParcelRiderType.reject);
              },
            );
          },
          itemCount: state.parcelRiderResponse.data.length,
        ).box.white.roundedSM.shadowSm.make().px16(),
      ],
    );
  }
}
