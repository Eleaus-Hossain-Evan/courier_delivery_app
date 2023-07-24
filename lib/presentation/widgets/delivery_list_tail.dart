import 'package:courier_delivery_app/presentation/customer_detail/customer_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:courier_delivery_app/presentation/widgets/k_inkwell.dart';

import '../../utils/utils.dart';

class DeliveryListTile extends StatelessWidget {
  const DeliveryListTile({
    Key? key,
    this.leadingImage = Images.deliveryBoxList,
    required this.customerName,
    required this.address,
    required this.distance,
  }) : super(key: key);

  final String leadingImage;
  final String customerName;
  final String address;
  final String distance;

  @override
  Widget build(BuildContext context) {
    return KInkWell(
            onTap: () {
              GoRouter.of(context).push(CustomerDetailScreen.route);
            },
            child: Row(
              crossAxisAlignment: crossStart,
              children: [
                leadingImage.circularAssetImage(
                  radius: 25.r,
                  bgColor: Colors.transparent,
                ),
                gap6,
                Flexible(
                  child: Column(
                    crossAxisAlignment: crossStart,
                    children: [
                      customerName.text.xl.bold.make(),
                      gap4,
                      Row(
                        crossAxisAlignment: crossStart,
                        children: [
                          const Icon(Icons.home_outlined)
                              .iconColor(context.theme.primaryColorDark)
                              .iconSize(16.sp),
                          gap4,
                          address.text.medium
                              .caption(context)
                              .color(ColorPalate.black700)
                              .make()
                              .box
                              .width(.5.sw)
                              .make(),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: mainSpaceBetween,
                  mainAxisSize: mainMax,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on)
                            .iconSize(16.sp)
                            .iconColor(context.theme.primaryColorDark),
                        distance.text.caption(context).make(),
                      ],
                    ),
                    gap24,
                    const Icon(Icons.arrow_forward_ios)
                        .iconColor(ColorPalate.secondary200)
                        .iconSize(16.sp),
                  ],
                ),
              ],
            ).p8())
        .box
        .color(ColorPalate.secondary.lighten().withOpacity(.01))
        .border(
          color: ColorPalate.secondary.lighten().withOpacity(.2),
          width: 1.2.w,
        )
        .roundedSM
        .make();
  }

  factory DeliveryListTile.loading({
    required String customerName,
    required String address,
    required String distance,
  }) =>
      DeliveryListTile(
        leadingImage: Images.deliveryBoxLoading,
        customerName: customerName,
        address: address,
        distance: distance,
      );
  factory DeliveryListTile.complete({
    required String customerName,
    required String address,
    required String distance,
  }) =>
      DeliveryListTile(
        leadingImage: Images.deliveryBoxCheck,
        customerName: customerName,
        address: address,
        distance: distance,
      );
}
