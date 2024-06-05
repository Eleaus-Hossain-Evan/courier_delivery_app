import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../domain/parcel/model/customer_info_model.dart';
import '../../../utils/utils.dart';

class ParcelCustomerInfoSection extends StatelessWidget {
  const ParcelCustomerInfoSection({
    super.key,
    required this.customer,
  });

  final CustomerInfoModel customer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        Row(
          mainAxisAlignment: mainCenter,
          children: [
            Images.iconUser.assetImage().circle(
                  radius: 22,
                  backgroundColor: context.colors.surface,
                  border: Border.all(color: AppColors.black700),
                ),
            gap10,
            'Customer Information'
                .text
                .bodySmall(context)
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              //, ---- Name ----

              Text.rich(
                'Name:  '
                    .textSpan
                    .withChildren([
                      customer.name.textSpan.semiBold.make(),
                    ])
                    .bodySmall(context)
                    .letterSpacing(.8)
                    .make(),
              ),
              gap6,

              //, ---- Address ----

              Text.rich(
                'Address:  '
                    .textSpan
                    .withChildren([
                      customer.address.textSpan.semiBold.make(),
                    ])
                    .bodySmall(context)
                    .letterSpacing(.8)
                    .make(),
              ),
              gap6,

              //, ---- Phone ----

              Text.rich(
                'Phone:  '
                    .textSpan
                    .withChildren([
                      customer.phone.textSpan.semiBold.make(),
                    ])
                    .bodySmall(context)
                    .letterSpacing(.8)
                    .make(),
              ),
              gap6,

              //, ---- Call Customer ----
              OutlinedButton.icon(
                onPressed: () async =>
                    await launchUrl(Uri(scheme: 'tel', path: customer.phone)),
                style: OutlinedButton.styleFrom(
                  padding: padding0,
                  foregroundColor: AppColors.black700,
                  side: const BorderSide(color: AppColors.black700),
                ),
                label: 'Call Customer'.text.make(),
                icon: const Icon(BoxIcons.bx_phone_call),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
