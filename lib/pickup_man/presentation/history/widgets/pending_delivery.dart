import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../presentation/widgets/widgets.dart';
import '../../../../utils/utils.dart';

class PendingDelivery extends StatelessWidget {
  const PendingDelivery({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bg100,
      child: KListViewSeparated(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        gap: 12,
        separator: HeightBox(18.h),
        itemBuilder: (context, index) {
          return DeliveryListTile.loading(
            customerName: "Evan Hossain",
            address: "169/B, North Konipara, Tejgoan, Dhaka, Bangladesh",
            distance: "3 kms",
          );
        },
        itemCount: 10,
      ),
    );
  }
}
