import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../presentation/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../../application/parcel_rider/parcel_rider_provider.dart';

class ParcelRiderListTile extends HookConsumerWidget {
  const ParcelRiderListTile({
    Key? key,
    required this.index,
    required this.onTapComplete,
    required this.onTapReject,
    required this.pageType,
  }) : super(key: key);

  final int index;

  final FutureOr<bool>? Function() onTapComplete;
  final FutureOr<bool>? Function() onTapReject;
  final ParcelRiderType pageType;

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(parcelRiderProvider);
    final model = state.parcelRiderResponse.data[index];

    final isReceived = useState(false);
    final isCanceled = useState(false);
    // final isUndo = useState(isReceived.value || isCanceled.value);

    Color getColor() {
      return model.status == ParcelRiderType.complete
          ? context.theme.primaryColor
          : model.status == ParcelRiderType.reject
              ? context.colors.error
              : ColorPalate.secondary200;
    }

    useEffect(() {
      Future.wait([
        Future.microtask(
            () => isReceived.value = model.status == ParcelRiderType.complete),
        Future.microtask(
            () => isCanceled.value = model.status == ParcelRiderType.reject),
      ]);
      return null;
    }, []);

    // Logger.i(model);

    return KInkWell(
      onTap: () {
        kShowBarModalBottomSheet(
          context: context,
          child: ParcelRiderDetailWidget(
            model: model,
            pageType: pageType,
            onTapComplete: onTapComplete,
            onTapReject: onTapReject,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          //  --- Customer Name ---
          Row(
            mainAxisAlignment: mainSpaceBetween,
            children: [
              model.parcel.customerInfo.name.text.xl.bold.make(),
              "${AppStrings.tkSymbol} ${model.parcel.regularPayment.cashCollection}"
                  .text
                  .bold
                  .colorPrimary(context)
                  .make()
                  .pSymmetric(h: 12.w, v: 2.h)
                  .box
                  .colorPrimary(context, opacity: .05)
                  .roundedSM
                  .border(color: context.colors.primary.withOpacity(.2))
                  .make(),
            ],
          ),
          gap8,

          //  --- Serial ID ---
          Text.rich(
            "Serial ID:  "
                .textSpan
                .withChildren([
                  model.parcel.serialId.textSpan
                      .color(Colors.blueGrey)
                      .semiBold
                      .caption(context)
                      .letterSpacing(1)
                      .make()
                ])
                .letterSpacing(.8)
                .make(),
          ),
          gap4,

          //  --- Phone & Address ---
          Column(
            crossAxisAlignment: crossStart,
            mainAxisSize: mainMin,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Phone:'),
                    WidgetSpan(child: SizedBox(width: 6.w)),
                    TextSpan(text: model.parcel.customerInfo.phone),
                  ],
                ),
              ),
              gap4,
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Address:'),
                    WidgetSpan(child: SizedBox(width: 6.w)),
                    TextSpan(text: model.parcel.customerInfo.address),
                  ],
                ),
              ),
              gap4,

              //   --- Material type && Weight ---
              Row(
                children: [
                  Visibility(
                    visible: model.parcel.regularParcelInfo.materialType.value
                        .isNotEmptyAndNotNull,
                    child: Row(
                      children: [
                        model.parcel.regularParcelInfo.materialType ==
                                ParcelMaterialType.fragile
                            ? const Icon(BoxIcons.bx_box).iconSize(18.sp)
                            : model.parcel.regularParcelInfo.materialType ==
                                    ParcelMaterialType.liquid
                                ? const Icon(Bootstrap.box_seam).iconSize(18.sp)
                                : const Icon(BoxIcons.bx_water).iconSize(18.sp),
                        gap4,
                        model.parcel.regularParcelInfo.materialType.value.text
                            .light
                            .make(),
                        gap4,
                        "|".text.make(),
                        gap4,
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Weight:'),
                        WidgetSpan(child: SizedBox(width: 6.w)),
                        TextSpan(text: model.parcel.regularParcelInfo.weight),
                      ],
                    ),
                  ),
                  const Spacer(),
                  VxCapsule(
                    height: 25.h,
                    width: 74.w,
                    border: Border.all(color: getColor().withOpacity(.4)),
                    backgroundColor: ColorPalate.bg100,
                    child: model.status.name
                        .toWordTitleCase()
                        .text
                        .xs
                        .semiBold
                        .color(getColor())
                        .letterSpacing(1.2)
                        .makeCentered()
                        .px12(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ).p16(),
    )
        .box
        .color(ColorPalate.secondary.lighten().withOpacity(.001))
        .roundedSM
        .make();
  }
}
