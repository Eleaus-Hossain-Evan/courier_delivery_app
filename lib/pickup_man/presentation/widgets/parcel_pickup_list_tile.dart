import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:courier_delivery_app/pickup_man/application/parcel_pickup/parcel_pickup_provider.dart';

import '../../../presentation/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../../domain/parcel/model/top_level_pickup_parcel_model.dart';
import 'parcel_pickup_detail/parcel_pickup_detail_widget.dart';

class ParcelPickupListTile extends HookConsumerWidget {
  const ParcelPickupListTile({
    Key? key,
    required this.model,
    required this.onTapReceive,
    required this.onTapCancel,
  }) : super(key: key);

  final TopLevelPickupParcelModel model;

  final FutureOr<bool>? Function(String) onTapReceive;
  final FutureOr<bool>? Function(String) onTapCancel;

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(parcelPickupProvider);
    // final model = state.parcelPickupResponse.data[index];

    final isReceived = useState(false);
    final isCanceled = useState(false);
    final isUndo = useState(isReceived.value || isCanceled.value);

    useEffect(() {
      Future.wait([
        Future.microtask(() =>
            isReceived.value = model.status == ParcelPickupStatus.received),
        Future.microtask(
            () => isCanceled.value = model.status == ParcelPickupStatus.cancel),
      ]);
      return null;
    }, []);

    // Logger.i(model);

    Color getColor() {
      return model.status == ParcelPickupStatus.received
          ? context.theme.primaryColor
          : model.status == ParcelPickupStatus.cancel
              ? context.colors.error
              : context.colors.secondary;
    }

    void undoToggle() {
      isUndo.value = !isUndo.value;
    }

    return KInkWell(
      onTap: () {
        kShowBarModalBottomSheet(
          context: context,
          child: ParcelPickupDetailWidget(
            model: model,
            onTapReceive: onTapReceive,
            onTapCancel: onTapCancel,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          Row(
            children: [
              const Icon(Bootstrap.info_circle)
                  .iconSize(16.sp)
                  .iconColor(context.theme.primaryColorDark),
              gap8,
              model.parcel.serialId.text
                  .caption(context)
                  .letterSpacing(.8)
                  .semiBold
                  .color(ColorPalate.black600)
                  .make()
                  .expand(),
              model.status.name.capitalized.text.xs
                  .color(getColor())
                  .bold
                  .letterSpacing(.8)
                  .makeCentered()
                  .pSymmetric(h: 12.w, v: 2.h)
                  .box
                  .rounded
                  .white
                  .border(color: getColor().withOpacity(.4))
                  .make(),
            ],
          ).p8().box.colorPrimary(context, opacity: .2).roundedSM.make(),
          gap8,
          Row(
            mainAxisAlignment: mainSpaceBetween,
            children: [
              model.parcel.merchantInfo.name.text.xl.bold.make(),
              "${AppStrings.tkSymbol} ${model.parcel.regularParcelInfo.productPrice}"
                  .text
                  .medium
                  .make(),
            ],
          ),
          gap4,
          Row(
            mainAxisAlignment: mainSpaceBetween,
            children: [
              Column(
                crossAxisAlignment: crossStart,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Phone:'),
                        WidgetSpan(child: SizedBox(width: 6.w)),
                        TextSpan(text: model.parcel.merchantInfo.phone),
                      ],
                    ),
                  ),
                  gap4,
                  Row(
                    children: [
                      ParcelTypeIcon(
                        model.parcel.regularParcelInfo.materialType,
                        size: 18,
                      ),
                      gap4,
                      model.parcel.regularParcelInfo.materialType.value.text
                          .light
                          .make(),
                      gap4,
                      "|".text.make(),
                      gap4,
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: 'Weight:'),
                            WidgetSpan(child: SizedBox(width: 6.w)),
                            TextSpan(
                                text: model.parcel.regularParcelInfo.weight),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ).expand(),

              // slider widgets

              SizedBox(
                width: .25.sw,
                height: 34.w,
                child: Visibility(
                  visible: !model.isComplete,
                  replacement: "Confirmed"
                      .text
                      .xl
                      .colorPrimary(context)
                      .makeCentered()
                      .box
                      .colorPrimary(context, opacity: .05)
                      .border(color: context.colors.primary.withOpacity(.2))
                      .make(),
                  child: AnimatedSwitcher(
                    // crossFadeState: isUndo.value
                    //     ? CrossFadeState.showSecond
                    //     : CrossFadeState.showFirst,
                    // secondCurve: Curves.easeOutCubic,
                    // alignment: Alignment.centerRight,
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeOutCubic,
                    duration: 800.milliseconds,
                    child: isUndo.value ||
                            model.status == ParcelPickupStatus.assign
                        ? Row(
                            mainAxisSize: mainMin,
                            mainAxisAlignment: mainEnd,
                            crossAxisAlignment: crossEnd,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  await onTapCancel.call('');
                                  undoToggle.call();
                                  // model.copyWith(status: ParcelPickupType.cancel);
                                  // final list = state.parcelPickupResponse.data.lock
                                  //     .replaceFirstWhere(
                                  //         (item) => item.id == model.id,
                                  //         (item) => model.copyWith(
                                  //             status: ParcelPickupType.cancel))
                                  //     .unlock;
                                  // ref
                                  //     .read(parcelPickupProvider.notifier)
                                  //     .setState(state.copyWith(
                                  //         parcelPickupResponse:
                                  //             state.parcelPickupResponse.copyWith(
                                  //       data: list,
                                  //     )));
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: padding0,
                                  foregroundColor: context.colors.primary,
                                ),
                                child: const Icon(EvaIcons.close),
                              ).box.square(34.w).make(),
                              gap18,
                              FilledButton(
                                onPressed: () async {
                                  await onTapReceive.call('');
                                  undoToggle.call();
                                },
                                style: FilledButton.styleFrom(
                                  padding: padding0,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Icon(BoxIcons.bx_check),
                              ).box.square(34.w).make(),
                            ],
                          )
                        : OutlinedButton(
                            onPressed: undoToggle,
                            style: IconButton.styleFrom(
                              padding: padding0,
                              foregroundColor: context.colors.secondary,
                              side: BorderSide(color: context.colors.secondary),
                            ),
                            child: const Icon(BoxIcons.bx_undo),
                          ).px8(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ).p16(),
    )
        .box
        .color(ColorPalate.secondary.lighten().withOpacity(.01))
        // .border(
        //   color: ColorPalate.secondary.lighten().withOpacity(.2),
        //   width: 1.2.w,
        // )
        .roundedSM
        .make();
  }
}
