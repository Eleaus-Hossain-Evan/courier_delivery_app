import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../presentation/widgets/widgets.dart';
import '../../../../../utils/utils.dart';
import '../../../../domain/parcel/model/top_level_pickup_parcel_model.dart';

class ParcelRegularInfoSection extends StatelessWidget {
  const ParcelRegularInfoSection({
    super.key,
    required this.model,
  });

  final TopLevelPickupParcelModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        Row(
          crossAxisAlignment: crossStart,
          children: [
            Column(
              children: [
                ParcelTypeIcon(
                  model.parcel.regularParcelInfo.materialType,
                  size: 56,
                ),
                gap4,
                model.parcel.regularParcelInfo.materialType.value
                    .toWordTitleCase()
                    .text
                    .bold
                    .xl
                    .make(),
              ],
            ).p12().box.roundedSM.colorScaffoldBackground(context).make(),
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
                  'Weight:  '
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
                  'Price:   '
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
                  'Quantity:  '
                      .textSpan
                      .withChildren([
                        model
                            .parcel.regularParcelInfo.category.textSpan.semiBold
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
      ],
    );
  }
}
