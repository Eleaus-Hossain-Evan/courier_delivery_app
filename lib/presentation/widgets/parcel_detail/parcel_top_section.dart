import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../rider/domain/top_level_rider_parcel_model.dart';
import '../../../utils/utils.dart';

class ParcelTopSection extends StatelessWidget {
  const ParcelTopSection({
    super.key,
    required this.model,
  });

  final TopLevelRiderParcelModel model;

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      return model.status == ParcelRiderType.complete
          ? context.theme.primaryColor
          : model.status == ParcelRiderType.reject
              ? context.colors.error
              : AppColors.secondary200;
    }

    return Column(
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
                          .bodyMedium(context)
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
            "Delivery Status:".text.make(),
            gap8,
            model.status.name.text.capitalize
                .color(AppColors.white)
                .bold
                .make()
                .pSymmetric(h: 8, v: 2)
                .box
                .roundedSM
                .color(getColor())
                .make(),
          ],
        ),
      ],
    );
  }
}
