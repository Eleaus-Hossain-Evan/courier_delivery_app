import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../utils/utils.dart';
import '../../../../domain/parcel/model/top_level_pickup_parcel_model.dart';

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
