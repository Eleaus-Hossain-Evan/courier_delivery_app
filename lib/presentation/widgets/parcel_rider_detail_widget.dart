import 'dart:async';

import 'package:courier_delivery_app/application/parcel_rider/parcel_rider_provider.dart';
import 'package:courier_delivery_app/domain/parcel/model/top_level_rider_parcel_model.dart';
import 'package:courier_delivery_app/presentation/widgets/k_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';

class ParcelRiderDetailWidget extends HookConsumerWidget {
  const ParcelRiderDetailWidget({
    super.key,
    required this.model,
    required this.onTapComplete,
    required this.onTapReject,
  });

  final TopLevelRiderParcelModel model;

  final FutureOr<bool>? Function() onTapComplete;
  final FutureOr<bool>? Function() onTapReject;
  @override
  Widget build(BuildContext context, ref) {
    final loading = useState(false);
    final isReceived = useState(false);
    final isCanceled = useState(false);
    final isUndo = useState(isReceived.value || isCanceled.value);

    final deliveryStatusList = useState([
      ParcelRiderType.values[2],
      ParcelRiderType.values[3],
    ]);
    final deliveryStatus = useState(model.status);

    final deliveryParcelStatusList = useState([
      ParcelRiderStatus.values[1],
      ParcelRiderStatus.values[3],
    ]);
    final deliveryParcelStatus = useState(model.parcelStatus);

    useEffect(() {
      Future.wait([
        Future.microtask(
            () => isReceived.value = model.status == ParcelRiderType.complete),
        Future.microtask(
            () => isCanceled.value = model.status == ParcelRiderType.reject),
      ]);
      return null;
    }, []);

    Color getColor() {
      return model.status == ParcelRiderType.complete
          ? context.theme.primaryColor
          : model.status == ParcelRiderType.reject
              ? context.colors.error
              : context.colors.secondary;
    }

    void undoToggle() {
      isUndo.value = !isUndo.value;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: crossStart,
          mainAxisSize: mainMin,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          'Delivery Information'
                              .textSpan
                              .bodyText1(context)
                              .letterSpacing(.8)
                              .make(),
                          // model.parcel.serialId.textSpan
                          //     .subtitle2(context)
                          //     .semiBold
                          //     .make(),
                        ],
                      ),
                    ),
                  ],
                )
                    .p(12.w)
                    .box
                    .colorPrimary(context, opacity: .2)
                    .roundedSM
                    .make()
                    .expand(),
                gap12,
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(EvaIcons.close),
                )
              ],
            ),
            gap16,
            Row(
              children: [
                const Icon(Bootstrap.info_circle)
                    .iconSize(18.sp)
                    .iconColor(context.theme.primaryColorDark),
                gap8,
                Text.rich("Delivery Status:  "
                        .textSpan
                        .withChildren([
                          model.status.name.textSpan.capitalize
                              .color(getColor())
                              .bold
                              .make()
                        ])
                        .letterSpacing(.8)
                        .make())
                    .box
                    .withDecoration(
                      const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: ColorPalate.black800),
                        ),
                      ),
                    )
                    .make(),
              ],
            ),
            gap16,
            ParcelCustomerInfoSection(model: model),
            gap16,
            Row(
              mainAxisAlignment: mainCenter,
              children: [
                Icon(
                  Bootstrap.boxes,
                  size: 14.sp,
                ).circle(
                  radius: 22,
                  backgroundColor: context.colors.background,
                  border: Border.all(color: ColorPalate.black700),
                ),
                gap10,
                'Parcel Information'
                    .text
                    .bodyText2(context)
                    .letterSpacing(.8)
                    .bold
                    .lg
                    .makeCentered(),
              ],
            )
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
            SizedBox(
              width: 1.sw,
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
                  child: isUndo.value || model.status == ParcelRiderType.assign
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: mainSpaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: crossStart,
                                  children: [
                                    "Status".text.make(),
                                    ...deliveryStatusList.value
                                        .map(
                                          (e) => Row(
                                            mainAxisSize: mainMin,
                                            children: [
                                              Radio<ParcelRiderType>(
                                                value: e,
                                                groupValue:
                                                    deliveryStatus.value,
                                                // materialTapTargetSize:
                                                //     MaterialTapTargetSize.shrinkWrap,
                                                // visualDensity: VisualDensity.compact,
                                                onChanged: (v) {
                                                  deliveryStatus.value = e;
                                                  if (e ==
                                                      ParcelRiderType.reject) {
                                                    deliveryParcelStatus.value =
                                                        ParcelRiderStatus.none;
                                                  }
                                                },
                                              ),
                                              (e.name.capitalized)
                                                  .text
                                                  .caption(context)
                                                  .make(),
                                            ],
                                          ),
                                        )
                                        .toList()
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: crossStart,
                                  children: [
                                    "Parcel Status".text.make(),
                                    ...deliveryParcelStatusList.value
                                        .map(
                                          (e) => Row(
                                            mainAxisSize: mainMin,
                                            children: [
                                              Radio<ParcelRiderStatus>(
                                                value: e,
                                                groupValue:
                                                    deliveryParcelStatus.value,
                                                // materialTapTargetSize:
                                                //     MaterialTapTargetSize.shrinkWrap,
                                                // visualDensity: VisualDensity.compact,
                                                onChanged: deliveryStatus
                                                            .value ==
                                                        ParcelRiderType.reject
                                                    ? null
                                                    : (v) =>
                                                        deliveryParcelStatus
                                                            .value = e,
                                              ),
                                              (e.name.capitalized)
                                                  .text
                                                  .caption(context)
                                                  .make(),
                                            ],
                                          ),
                                        )
                                        .toList()
                                  ],
                                ),
                              ],
                            ).px16(),
                            KOutlinedButton(
                              text: "Done",
                              loading: loading,
                              onPressed: () async {
                                loading.value = true;
                                await ref
                                    .read(parcelRiderProvider.notifier)
                                    .riderParcelUpdate(
                                      parcelId: model.id,
                                      cashCollected: model
                                          .parcel.regularPayment.cashCollection
                                          .toInt(),
                                      status: deliveryStatus.value,
                                      parcelStatus: deliveryParcelStatus.value,
                                    )
                                    .then((value) {
                                  loading.value = false;
                                  Navigator.pop(context);
                                });
                              },
                              isSecondary: false,
                            )
                          ],
                        )
                      : KElevatedButton(
                          onPressed: undoToggle,
                          backgroundColor: context.colors.secondary,
                          foregroundColor:
                              context.theme.scaffoldBackgroundColor,
                          text: 'Undo',
                        ).px8(),
                ).p16().box.roundedSM.colorScaffoldBackground(context).make(),
              ),
            ),
            gap16,
          ],
        ),
      ),
    );
  }
}

class ParcelCustomerInfoSection extends StatelessWidget {
  const ParcelCustomerInfoSection({
    super.key,
    required this.model,
  });

  final TopLevelRiderParcelModel model;

  @override
  Widget build(BuildContext context) {
    final Uri phoneLaunchUri =
        Uri(scheme: 'tel', path: model.parcel.customerInfo.phone);
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        Row(
          mainAxisAlignment: mainCenter,
          children: [
            Icon(
              BoxIcons.bx_user,
              size: 16.sp,
            ).circle(
              radius: 22,
              backgroundColor: context.colors.background,
              border: Border.all(color: ColorPalate.black700),
            ),
            gap10,
            'Customer Information'
                .text
                .bodyText2(context)
                .letterSpacing(.8)
                .bold
                .lg
                .makeCentered(),
          ],
        )
            .p8()
            .box
            .width(1.sw)
            .colorScaffoldBackground(context)
            .roundedSM
            .make(),
        gap10,
        [
          Text.rich(
            'Name:  '
                .textSpan
                .withChildren([
                  model.parcel.customerInfo.name.textSpan.semiBold.make(),
                ])
                .bodyText2(context)
                .letterSpacing(.8)
                .make(),
          ),
          gap6,
          Text.rich(
            'Address:  '
                .textSpan
                .withChildren([
                  model.parcel.customerInfo.address.textSpan.semiBold.make(),
                ])
                .bodyText2(context)
                .letterSpacing(.8)
                .make(),
          ),
          gap6,
          Text.rich(
            'Phone:  '
                .textSpan
                .withChildren([
                  model.parcel.customerInfo.phone.textSpan.semiBold.make(),
                ])
                .bodyText2(context)
                .letterSpacing(.8)
                .make(),
          ),
          gap6,
          OutlinedButton.icon(
            onPressed: () async => await launchUrl(phoneLaunchUri),
            style: OutlinedButton.styleFrom(
              padding: padding0,
              foregroundColor: ColorPalate.black700,
              side: const BorderSide(color: ColorPalate.black700),
            ),
            label: 'Call Now'.text.make(),
            icon: const Icon(BoxIcons.bx_phone_call),
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

  final TopLevelRiderParcelModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88.h,
      child: Row(
        crossAxisAlignment: crossStart,
        children: [
          Visibility(
            visible: model
                .parcel.regularParcelInfo.materialType.isNotEmptyAndNotNull,
            child: Visibility(
              visible: model.parcel.regularParcelInfo.materialType == "fragile",
              replacement: Column(
                children: [
                  const Icon(BoxIcons.bx_water).iconSize(30.sp),
                  gap4,
                  model.parcel.regularParcelInfo.materialType.capitalized.text
                      .bold.xl
                      .make(),
                ],
              ).box.roundedSM.colorPrimary(context).make(),
              child: Column(
                children: [
                  const Icon(BoxIcons.bx_box).iconSize(30.sp),
                  gap4,
                  model.parcel.regularParcelInfo.materialType.capitalized.text
                      .bold.xl
                      .make(),
                ],
              ).p12().box.roundedSM.colorScaffoldBackground(context).make(),
            ),
          ),
          gap16,
          Column(
            mainAxisAlignment: mainSpaceAround,
            crossAxisAlignment: crossStart,
            mainAxisSize: mainMax,
            children: [
              Text.rich(
                'Created At:  '
                    .textSpan
                    .withChildren([
                      model.createdAt
                          .toFormatShortDate()
                          .textSpan
                          .italic
                          .light
                          .blue900
                          .make(),
                    ])
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

  final TopLevelRiderParcelModel model;

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
          Row(
            mainAxisAlignment: mainCenter,
            children: [
              Icon(
                BoxIcons.bx_detail,
                size: 14.sp,
              ).circle(
                radius: 22,
                backgroundColor: context.colors.background,
                border: Border.all(color: ColorPalate.black700),
              ),
              gap10,
              'Parcel Details'
                  .text
                  .bodyText2(context)
                  .letterSpacing(.8)
                  .bold
                  .lg
                  .makeCentered(),
            ],
          )
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
