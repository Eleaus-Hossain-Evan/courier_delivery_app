import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';

class WorkingSummery extends StatelessWidget {
  const WorkingSummery({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainSpaceBetween,
      children: [
        const WorkingSummeryItem(
          icon: Icons.access_time_filled,
          title: "Pending Delivery",
          count: "23",
          textColor: ColorPalate.secondary200,
          bgColor: ColorPalate.secondary,
        ),
        WorkingSummeryItem(
          icon: Icons.delivery_dining,
          title: "Canceled Delivery",
          count: "43",
          textColor: context.color.error,
          bgColor: context.color.error,
        ),
        const WorkingSummeryItem(
          icon: Icons.check_circle,
          title: "Complete Delivery",
          count: "124",
          textColor: ColorPalate.primary200,
          bgColor: ColorPalate.primary,
        ),
      ],
    );
  }
}

class WorkingSummeryItem extends StatelessWidget {
  const WorkingSummeryItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.count,
    required this.textColor,
    required this.bgColor,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String count;
  final Color textColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        Icon(
          icon,
          color: textColor,
        ),
        gap4,
        count.text.xl2.bold.color(textColor).make(),
        gap6,
        title.text.minFontSize(5).maxFontSize(9).bold.color(textColor).make(),
      ],
    )
        .box
        .color(bgColor.withOpacity(.3))
        .roundedSM
        .width(.28.sw)
        .p12
        .make()
        .box
        .white
        .roundedSM
        .shadowSm
        .make();
  }
}
