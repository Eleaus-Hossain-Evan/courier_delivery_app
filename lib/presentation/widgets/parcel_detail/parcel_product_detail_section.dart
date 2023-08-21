import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../domain/parcel/model/top_level_rider_parcel_model.dart';
import '../../../utils/utils.dart';

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
            mainAxisAlignment: mainStart,
            children: [
              Icon(
                BoxIcons.bx_detail,
                size: 8.sp,
              ).circle(
                radius: 16,
                backgroundColor: context.colors.background,
                border: Border.all(color: ColorPalate.black700),
              ),
              gap4,
              'Parcel Details'
                  .text
                  .bodyText2(context)
                  .base
                  .bold
                  .letterSpacing(.8)
                  .makeCentered(),
            ],
          ),
          model.parcel.regularParcelInfo.details.text.lg
              .letterSpacing(.8)
              .make()
              .pSymmetric(h: 16.w, v: 8.w),
        ],
      ),
    );
  }
}
