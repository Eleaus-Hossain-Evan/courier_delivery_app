import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../domain/parcel/model/regular_parcel_info_model.dart';
import '../../../utils/utils.dart';

class ParcelRegularInfoSection extends StatelessWidget {
  const ParcelRegularInfoSection({
    super.key,
    required this.regularParcel,
    required this.createdAt,
  });

  final RegularParcelInfoModel regularParcel;
  final String createdAt;

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
              border: Border.all(color: AppColors.black700),
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
                visible: regularParcel.materialType.value.isNotEmptyAndNotNull,
                child: Column(
                  children: [
                    regularParcel.materialType == ParcelMaterialType.regular
                        ? const Icon(BoxIcons.bx_box).iconSize(18.sp)
                        : regularParcel.materialType ==
                                ParcelMaterialType.fragile
                            ? const Icon(Bootstrap.box_seam).iconSize(18.sp)
                            : const Icon(BoxIcons.bx_water).iconSize(18.sp),
                    gap4,
                    regularParcel.materialType.value.capitalized.text.bold.xl
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
                    'Created At:  '
                        .textSpan
                        .withChildren([
                          createdAt
                              .toFormatShortDate()
                              .textSpan
                              .italic
                              .light
                              .blue900
                              .make(),
                        ])
                        .bodySmall(context)
                        .letterSpacing(.8)
                        .make(),
                  ),
                  Text.rich(
                    'Weight:  '
                        .textSpan
                        .withChildren([
                          regularParcel.weight.textSpan.semiBold.make(),
                        ])
                        .bodySmall(context)
                        .letterSpacing(.8)
                        .make(),
                  ),
                  Text.rich(
                    'Category:  '
                        .textSpan
                        .withChildren([
                          (regularParcel.category.isNotEmptyAndNotNull
                                  ? regularParcel.category
                                  : '-')
                              .textSpan
                              .semiBold
                              .make(),
                        ])
                        .bodySmall(context)
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
