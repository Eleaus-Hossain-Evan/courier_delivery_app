import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../utils/utils.dart';
import '../../../../domain/parcel/model/top_level_pickup_parcel_model.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.model,
  });

  final TopLevelPickupParcelModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            const Icon(Bootstrap.info_circle)
                .iconSize(16.sp)
                .iconColor(context.theme.primaryColorDark),
            gap4,
            Text.rich(
              TextSpan(
                children: [
                  'Serial ID: '.textSpan.bodySmall(context).make(),
                  model.parcel.serialId.textSpan
                      .bodySmall(context)
                      .letterSpacing(.8)
                      .semiBold
                      .make(),
                ],
              ),
            ),
          ],
        ).p8().box.colorPrimary(context, opacity: .2).roundedSM.make().expand(),
        gap8,
        SizedBox(
          width: 32.w,
          height: 32.w,
          child: IconButton.outlined(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(EvaIcons.close),
          ),
        )
      ],
    );
  }
}
