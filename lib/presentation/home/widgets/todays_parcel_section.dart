import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../application/parcel_rider/parcel_rider_state.dart';
import '../../../utils/utils.dart';
import '../../main_nav/main_nav.dart';
import '../../widgets/widgets.dart';

const Color _kKeyUmbraOpacity = Color(0x33000000); // alpha = 0.2
const Color _kKeyPenumbraOpacity = Color(0x24000000); // alpha = 0.14
const Color _kAmbientShadowOpacity = Color(0x1F000000); // alpha = 0.12

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
        Container(
          margin: paddingH16,
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
                pageType: ParcelRiderType.all,
                onTapComplete: () {
                  return null;

                  // return await ref
                  //     .read(parcelRiderProvider.notifier)
                  //     .receivedParcel(parcel.id, page.value,
                  //         shouldRemove:
                  //             currentType.value == ParcelRiderType.complete);
                },
                onTapReject: () {
                  return null;

                  // return await ref
                  //     .read(parcelRiderProvider.notifier)
                  //     .cancelParcel(parcel.id, page.value,
                  //         shouldRemove:
                  //             currentType.value == ParcelRiderType.reject);
                },
              );
            },
            itemCount: state.parcelRiderResponse.data.length,
          ),
        ),
      ],
    );
  }
}
