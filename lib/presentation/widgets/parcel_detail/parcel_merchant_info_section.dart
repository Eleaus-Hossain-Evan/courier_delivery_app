import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../domain/parcel/model/merchant_info_model.dart';
import '../../../utils/utils.dart';

class ParcelMerchantInfoSection extends StatelessWidget {
  const ParcelMerchantInfoSection({
    super.key,
    required this.merchant,
  });

  final MerchantInfoModel merchant;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        Row(
          mainAxisAlignment: mainCenter,
          children: [
            Icon(
              Bootstrap.shop,
              size: 14.sp,
            ).circle(
              radius: 22,
              backgroundColor: context.colors.surface,
              border: Border.all(color: AppColors.black700),
            ),
            gap10,
            'Merchant Information'
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              Text.rich(
                'Name:  '
                    .textSpan
                    .withChildren([
                      merchant.name.textSpan.semiBold.make(),
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
                      merchant.address.textSpan.semiBold.make(),
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
                      merchant.phone.textSpan.semiBold.make(),
                    ])
                    .bodySmall(context)
                    .letterSpacing(.8)
                    .make(),
              ),
              gap6,
              Text.rich(
                'Shop Name:  '
                    .textSpan
                    .withChildren([
                      merchant.shopName.textSpan.semiBold.make(),
                    ])
                    .bodySmall(context)
                    .letterSpacing(.8)
                    .make(),
              ),
              gap6,
              Text.rich(
                'Shop Address:  '
                    .textSpan
                    .withChildren([
                      merchant.shopAddress.textSpan.semiBold.make(),
                    ])
                    .bodySmall(context)
                    .letterSpacing(.8)
                    .make(),
              ),
              gap16,
              OutlinedButton.icon(
                onPressed: () async =>
                    await launchUrl(Uri(scheme: 'tel', path: merchant.phone)),
                style: OutlinedButton.styleFrom(
                  padding: padding0,
                  foregroundColor: AppColors.black700,
                  side: const BorderSide(color: AppColors.black700),
                ),
                label: 'Call Merchant'.text.make(),
                icon: const Icon(BoxIcons.bx_phone_call),
              ),
            ],
          ),
        )
      ],
    );
  }
}
