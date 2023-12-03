import 'package:courier_delivery_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomerDetailScreen extends HookConsumerWidget {
  static const String route = "/customer-detail";
  const CustomerDetailScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Detail"),
      ),
      body: SingleChildScrollView(
        padding: padding16,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: crossEnd,
              children: [
                Image.asset(
                  Images.deliveryBoxes3d,
                  height: .15.sh,
                  width: .3.sw,
                  fit: BoxFit.cover,
                )
                    .p12()
                    .box
                    .white
                    .roundedSM
                    .border(
                      color: context.colors.secondaryContainer.withOpacity(.2),
                      width: 1.2.w,
                    )
                    .make(),
                gap16,
                Column(
                  crossAxisAlignment: crossStart,
                  children: [
                    "Date: 02/23/12".text.make(),
                    gap6,
                    "Order #12134234234123".text.make(),
                    gap6,
                    "Eleaus Hossain Evan"
                        .text
                        .xl
                        .color(context.theme.primaryColorDark)
                        .semiBold
                        .make(),
                  ],
                ),
              ],
            ),
            gap16,
            "Address : 169/B, North Konipara, Tejgoan, Dhaka, Bangladesh"
                .text
                .lg
                .semiBold
                .color(AppColors.black700)
                .make(),
          ],
        ),
      ),
    );
  }
}
