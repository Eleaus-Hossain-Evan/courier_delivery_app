import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../domain/parcel/model/top_level_rider_parcel_model.dart';
import '../../../utils/utils.dart';

class ParcelRegularInfoSection extends StatelessWidget {
  const ParcelRegularInfoSection({
    super.key,
    required this.model,
  });

  final TopLevelRiderParcelModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        SizedBox(
          height: 88.h,
          child: Row(
            crossAxisAlignment: crossStart,
            children: [
              Visibility(
                visible: model
                    .parcel.regularParcelInfo.materialType.isNotEmptyAndNotNull,
                child: Visibility(
                  visible:
                      model.parcel.regularParcelInfo.materialType == "fragile",
                  replacement: Column(
                    children: [
                      const Icon(BoxIcons.bx_water).iconSize(30.sp),
                      gap4,
                      model.parcel.regularParcelInfo.materialType.capitalized
                          .text.bold.xl
                          .make(),
                    ],
                  ).box.roundedSM.colorPrimary(context).make(),
                  child: Column(
                    children: [
                      const Icon(BoxIcons.bx_box).iconSize(30.sp),
                      gap4,
                      model.parcel.regularParcelInfo.materialType.capitalized
                          .text.bold.xl
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
                          model
                              .parcel.regularParcelInfo.weight.textSpan.semiBold
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
                          model.parcel.regularParcelInfo.category.textSpan
                              .semiBold
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
        ),
      ],
    );
  }
}
