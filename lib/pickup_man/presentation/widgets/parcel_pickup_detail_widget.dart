import 'dart:async';

import 'package:courier_delivery_app/presentation/widgets/k_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';
import '../../domain/parcel/model/top_level_pickup_parcel_model.dart';

class ParcelPickupDetailWidget extends HookConsumerWidget {
  const ParcelPickupDetailWidget({
    super.key,
    required this.model,
    required this.onTapReceive,
    required this.onTapCancel,
  });

  final TopLevelPickupParcelModel model;

  final FutureOr<bool>? Function() onTapReceive;
  final FutureOr<bool>? Function() onTapCancel;

  @override
  Widget build(BuildContext context, ref) {
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

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: crossStart,
        mainAxisSize: mainMin,
        children: [
          Row(
            children: [
              Row(
                children: [
                  const Icon(Bootstrap.info_circle)
                      .iconSize(16.sp)
                      .iconColor(context.theme.primaryColorDark),
                  gap8,
                  Text.rich(
                    TextSpan(
                      children: [
                        'Serial ID: '.textSpan.bodyText2(context).make(),
                        model.parcel.serialId.textSpan
                            .subtitle2(context)
                            .semiBold
                            .make(),
                      ],
                    ),
                  ),
                ],
              )
                  .p8()
                  .box
                  .colorPrimary(context, opacity: .2)
                  .roundedSM
                  .make()
                  .expand(),
              gap12,
              IconButton.outlined(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(EvaIcons.close),
              )
            ],
          ),
          gap16,
          model.status.name.capitalized.text.lg
              .color(getColor())
              .bold
              .letterSpacing(.8)
              .makeCentered()
              .pSymmetric(h: 12.w, v: 6.h)
              .box
              .roundedSM
              .color(getColor().withOpacity(.05))
              .border(color: getColor().withOpacity(.4))
              .make(),
          gap16,
          'Parcel Information'
              .text
              .bodyText2(context)
              .letterSpacing(.8)
              .bold
              .lg
              .makeCentered()
              .p8()
              .box
              .width(1.sw)
              .colorScaffoldBackground(context)
              .roundedSM
              .make(),
          gap8,
          ParcelRegularInfoSection(model: model),
          gap16,
          ParcelProductDetailSection(model: model),
          gap16,
          ParcelMerchantInfoSection(model: model),
          gap16,
          SizedBox(
            width: 1.sw,
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
                            child: "Cancel".text.base.make(),
                          ).flexible(),
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
                            child: "Receive".text.base.make(),
                          ).flexible(),
                        ],
                      )
                    : KElevatedButton(
                        onPressed: undoToggle,
                        backgroundColor: context.colors.secondary,
                        foregroundColor: context.theme.scaffoldBackgroundColor,
                        text: 'Undo',
                      ).px8(),
              ),
            ),
          ),
          gap16,
        ],
      ),
    );
  }
}

class ParcelMerchantInfoSection extends StatelessWidget {
  const ParcelMerchantInfoSection({
    super.key,
    required this.model,
  });

  final TopLevelPickupParcelModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        'Merchant Information'
            .text
            .bodyText2(context)
            .letterSpacing(.8)
            .bold
            .lg
            .makeCentered()
            .p8()
            .box
            .width(1.sw)
            .colorScaffoldBackground(context)
            .roundedSM
            .make(),
        [
          Text.rich(
            'Name:  '
                .textSpan
                .withChildren([
                  model.parcel.merchantInfo.name.textSpan.semiBold.make(),
                ])
                .bodyText2(context)
                .letterSpacing(.8)
                .make(),
          ),
          gap2,
          Text.rich(
            'Address:  '
                .textSpan
                .withChildren([
                  model.parcel.merchantInfo.address.textSpan.semiBold.make(),
                ])
                .bodyText2(context)
                .letterSpacing(.8)
                .make(),
          ),
          gap2,
          Text.rich(
            'Phone:  '
                .textSpan
                .withChildren([
                  model.parcel.merchantInfo.phone.textSpan.semiBold.make(),
                ])
                .bodyText2(context)
                .letterSpacing(.8)
                .make(),
          ),
          gap2,
          Text.rich(
            'Shop Name:  '
                .textSpan
                .withChildren([
                  model.parcel.merchantInfo.shopName.textSpan.semiBold.make(),
                ])
                .bodyText2(context)
                .letterSpacing(.8)
                .make(),
          ),
          gap2,
          Text.rich(
            'Shop Address:  '
                .textSpan
                .withChildren([
                  model.parcel.merchantInfo.shopAddress.textSpan.semiBold
                      .make(),
                ])
                .bodyText2(context)
                .letterSpacing(.8)
                .make(),
          ),
        ].vStack(crossAlignment: crossStart).pSymmetric(h: 16.w, v: 8.w)
      ],
    );
  }
}

class ParcelRegularInfoSection extends StatelessWidget {
  const ParcelRegularInfoSection({
    super.key,
    required this.model,
  });

  final TopLevelPickupParcelModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: Row(
        crossAxisAlignment: crossStart,
        children: [
          Visibility(
            visible: model.parcel.regularParcelInfo.materialType == "fragile",
            replacement: Column(
              children: [
                const Icon(BoxIcons.bx_water).iconSize(64.sp),
                gap4,
                model.parcel.regularParcelInfo.materialType.capitalized.text
                    .bold.xl
                    .make(),
              ],
            ).box.roundedSM.colorPrimary(context).make(),
            child: Column(
              children: [
                const Icon(BoxIcons.bx_box).iconSize(56.sp),
                gap4,
                model.parcel.regularParcelInfo.materialType.capitalized.text
                    .bold.xl
                    .make(),
              ],
            ).p12().box.roundedSM.colorScaffoldBackground(context).make(),
          ),
          gap16,
          Column(
            mainAxisAlignment: mainSpaceAround,
            crossAxisAlignment: crossStart,
            mainAxisSize: mainMax,
            children: [
              Text.rich(
                'Update At:  '
                    .textSpan
                    .withChildren([
                      model.updatedAt
                          .toFormatShortDate()
                          .textSpan
                          .italic
                          .light
                          .blue900
                          .make(),
                    ])
                    .underline
                    .bodyText2(context)
                    .letterSpacing(.8)
                    .make(),
              ),
              Text.rich(
                'Parcel Weight:  '
                    .textSpan
                    .withChildren([
                      model.parcel.regularParcelInfo.weight.textSpan.semiBold
                          .make(),
                    ])
                    .bodyText2(context)
                    .letterSpacing(.8)
                    .make(),
              ),
              Text.rich(
                'Parcel Price:   '
                    .textSpan
                    .withChildren([
                      model.parcel.regularParcelInfo.productPrice
                          .toString()
                          .textSpan
                          .semiBold
                          .make(),
                    ])
                    .bodyText2(context)
                    .letterSpacing(.8)
                    .make(),
              ),
              Text.rich(
                'Parcel Quantity:  '
                    .textSpan
                    .withChildren([
                      model.parcel.regularParcelInfo.category.textSpan.semiBold
                          .make(),
                    ])
                    .bodyText2(context)
                    .letterSpacing(.8)
                    .make(),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ParcelProductDetailSection extends StatelessWidget {
  const ParcelProductDetailSection({
    super.key,
    required this.model,
  });

  final TopLevelPickupParcelModel model;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: model.parcel.regularParcelInfo.details.isNotEmptyAndNotNull,
      replacement: Text.rich(
        'Parcel Detail:  '
            .textSpan
            .withChildren([
              'No Detail added...'.textSpan.semiBold.make(),
            ])
            .bodyText2(context)
            .letterSpacing(.8)
            .make(),
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          'Parcel Detail'
              .text
              .bodyText2(context)
              .letterSpacing(.8)
              .bold
              .lg
              .makeCentered()
              .p8()
              .box
              .width(1.sw)
              .colorScaffoldBackground(context)
              .roundedSM
              .make(),
          model.parcel.regularParcelInfo.details.text.lg
              .letterSpacing(.8)
              .make()
              .pSymmetric(h: 16.w, v: 8.w),
        ],
      ),
    );
  }
}
