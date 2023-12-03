import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../application/parcel_rider/parcel_rider_provider.dart';
import '../../../../utils/utils.dart';
import '../../main_nav/main_nav_rider.dart';
import '../../../../presentation/widgets/widgets.dart';

class TodaysParcelSection extends HookConsumerWidget {
  const TodaysParcelSection({
    super.key,
    required this.page,
    required this.currentType,
  });

  final ValueNotifier<int> page;
  final ValueNotifier<ParcelRiderType> currentType;

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(parcelRiderProvider);
    return Column(
      children: [
        Row(
          mainAxisAlignment: mainSpaceBetween,
          children: [
            AppStrings.todayDelivery.text.bold.lg
                .color(AppColors.black900)
                .make(),
            AppStrings.viewAll.text
                .color(AppColors.secondary200)
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
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(7.5.r),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0.0, 3.0),
                        blurRadius: 1.0,
                        spreadRadius: -2.0,
                        color: AppColors.kKeyUmbraOpacity),
                    BoxShadow(
                        offset: Offset(0.0, 2.0),
                        blurRadius: 2.0,
                        color: AppColors.kKeyPenumbraOpacity),
                    BoxShadow(
                        offset: Offset(0.0, 1.0),
                        blurRadius: 5.0,
                        color: AppColors.kAmbientShadowOpacity),
                  ],
                ),
          child: KListViewSeparated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gap: 16,
            padding: padding0,
            separator: const KDivider(color: AppColors.bg300),
            itemBuilder: (context, index) {
              // final parcel = state.parcelRiderResponse.data[index];
              return ParcelRiderListTile(
                index: index,
                pageType: ParcelRiderType.all,
              );
            },
            itemCount: state.parcelRiderResponse.data.length,
          ),
        ),
      ],
    );
  }
}
