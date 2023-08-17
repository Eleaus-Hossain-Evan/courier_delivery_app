import 'dart:async';

import 'package:courier_delivery_app/pickup_man/application/parcel_pickup/parcel_pickup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../presentation/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../../domain/parcel/model/top_level_common_parcel_model.dart';

class ParcelListTile extends HookConsumerWidget {
  const ParcelListTile({
    Key? key,
    required this.index,
    required this.onTapReceive,
    required this.onTapCancel,
  }) : super(key: key);

  final int index;

  final FutureOr<bool> Function() onTapReceive;
  final FutureOr<bool> Function() onTapCancel;

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(parcelPickupProvider);
    final model = state.parcelPickupResponse.data[index];

    final isReceived = useState(false);
    final isCanceled = useState(false);
    final isUndo = useState(isReceived.value || isCanceled.value);

    useEffect(() {
      Future.wait([
        Future.microtask(
            () => isReceived.value = model.status == ParcelPickupType.received),
        Future.microtask(
            () => isCanceled.value = model.status == ParcelPickupType.cancel),
      ]);
      return null;
    }, []);

    // Logger.i(model);

    Color getColor() {
      return model.status == ParcelPickupType.received
          ? context.theme.primaryColor
          : model.status == ParcelPickupType.cancel
              ? context.colors.error
              : context.colors.secondary;
    }

    void undoToggle() {
      isUndo.value = !isUndo.value;
    }

    return KInkWell(
      onTap: () {
        // GoRouter.of(context).push(CustomerDetailScreen.route);
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
              model.parcel.regularParcelInfo.productPrice.text.medium.make(),
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
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Address:'),
                        WidgetSpan(child: SizedBox(width: 6.w)),
                        TextSpan(text: model.parcel.merchantInfo.address),
                      ],
                    ),
                  ),
                ],
              ).expand(),

              // slider widgets

              AnimatedSwitcher(
                // crossFadeState: isUndo.value
                //     ? CrossFadeState.showSecond
                //     : CrossFadeState.showFirst,
                // secondCurve: Curves.easeOutCubic,
                // alignment: Alignment.centerRight,
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeOutCubic,
                duration: 800.milliseconds,
                child: isUndo.value || model.status == ParcelPickupType.assign
                    ? Row(
                        mainAxisSize: mainMin,
                        mainAxisAlignment: mainEnd,
                        crossAxisAlignment: crossEnd,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await onTapCancel.call();
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
                              await onTapReceive.call();
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
                    : IconButton.outlined(
                        onPressed: undoToggle,
                        style: IconButton.styleFrom(
                          padding: padding0,
                          foregroundColor: context.colors.secondary,
                          side: BorderSide(color: context.colors.secondary),
                        ),
                        icon: const Icon(BoxIcons.bx_undo),
                      ),
              )
            ],
          ),
        ],
      ).p16(),
    )
        .box
        .color(ColorPalate.secondary.lighten().withOpacity(.01))
        .border(
          color: ColorPalate.secondary.lighten().withOpacity(.2),
          width: 1.2.w,
        )
        .roundedSM
        .make();
  }
}
