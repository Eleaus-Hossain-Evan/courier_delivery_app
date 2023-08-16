import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../presentation/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../../domain/parcel/model/top_level_common_parcel_model.dart';

class ParcelListTile extends StatelessWidget {
  const ParcelListTile({
    Key? key,
    required this.model,
    required this.onTapReceive,
    required this.onTapCancel,
  }) : super(key: key);

  final TopLevelCommonParcelModel model;

  final Function() onTapReceive;
  final Function() onTapCancel;

  @override
  Widget build(BuildContext context) {
    return KInkWell(
      onTap: () {
        // GoRouter.of(context).push(CustomerDetailScreen.route);
      },
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          Row(
            children: [
              const Icon(Bootstrap.info_circle)
                  .iconSize(16.sp)
                  .iconColor(context.theme.primaryColorDark),
              gap8,
              model.parcel.serialId.text
                  .caption(context)
                  .letterSpacing(.8)
                  .semiBold
                  .color(ColorPalate.black600)
                  .make(),
            ],
          ).p8().box.colorPrimary(context, opacity: .2).roundedSM.make(),
          gap8,
          Row(
            mainAxisAlignment: mainSpaceBetween,
            children: [
              model.parcel.merchantInfo.name.text.xl.bold.make(),
              model.parcel.regularParcelInfo.productPrice.text.medium.make(),
            ],
          ),
          gap4,
          Row(
            mainAxisAlignment: mainSpaceBetween,
            children: [
              Column(
                crossAxisAlignment: crossStart,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Phone:'),
                        WidgetSpan(child: SizedBox(width: 6.w)),
                        TextSpan(text: model.parcel.merchantInfo.phone),
                      ],
                    ),
                  ),
                  gap4,
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Address:'),
                        WidgetSpan(child: SizedBox(width: 6.w)),
                        TextSpan(text: model.parcel.merchantInfo.address),
                      ],
                    ),
                  ),
                ],
              ).expand(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: padding0,
                  foregroundColor: context.colors.primary,
                ),
                child: const Icon(EvaIcons.close),
              ).box.square(34.w).make(),
              gap18,
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  padding: padding0,
                  foregroundColor: Colors.white,
                ),
                child: const Icon(BoxIcons.bx_check),
              ).box.square(34.w).make()
            ],
          ),
        ],
      ).p16(),
    )
        .box
        .color(ColorPalate.secondary.lighten().withOpacity(.01))
        .border(
          color: ColorPalate.secondary.lighten().withOpacity(.2),
          width: 1.2.w,
        )
        .roundedSM
        .make();
  }
}
