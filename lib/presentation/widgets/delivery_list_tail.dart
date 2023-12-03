import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';
import 'widgets.dart';

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
              // GoRouter.of(context).push(CustomerDetailScreen.route);
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
                              .color(AppColors.black700)
                              .make()
                              .box
                              .width(.5.sw)
                              .make(),
                        ],
                      ),
                      gap4,
                      Row(
                        children: [
                          const Icon(Icons.location_on)
                              .iconSize(16.sp)
                              .iconColor(context.theme.primaryColorDark),
                          distance.text.caption(context).make(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ).p8())
        .box
        .color(AppColors.secondary.lighten().withOpacity(.01))
        .border(
          color: AppColors.secondary.lighten().withOpacity(.2),
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
