import 'package:courier_delivery_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../domain/parcel/model/top_level_pickup_parcel_model.dart';

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
        ''
            .textSpan
            .withChildren([
              'No Detail added...'.textSpan.make(),
            ])
            .caption(context)
            .letterSpacing(.8)
            .make(),
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          'Detail'
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
