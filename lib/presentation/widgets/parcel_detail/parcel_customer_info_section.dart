import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../domain/parcel/model/top_level_rider_parcel_model.dart';
import '../../../utils/utils.dart';

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
            Images.iconUser.assetImage().circle(
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
                .bodySmall(context)
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
                .bodySmall(context)
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
                .bodySmall(context)
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
