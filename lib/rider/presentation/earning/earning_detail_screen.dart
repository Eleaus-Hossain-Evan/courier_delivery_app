import 'package:courier_delivery_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../application/auth/auth_provider.dart';
import '../../../presentation/widgets/widgets.dart';
import '../../../utils/utils.dart';

class EarningDetailScreen extends HookConsumerWidget {
  static const route = '/earning-detail';

  const EarningDetailScreen({
    super.key,
    required this.id,
  });

  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    return Scaffold(
      appBar: const KAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            Text(
              "Date: 12/12/2021",
              style: context.labelSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.black800,
              ),
            ),

            gap16,
            //. Order Status & Address

            ContainerBGWhiteSlideFromRight(
              borderColor: context.colors.secondaryContainer.withOpacity(.2),
              bgColor: AppColors.primary.lighten(42),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  ExpansionTile(
                    title: const Text(
                      "Rider",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    tilePadding: padding0,
                    childrenPadding: paddingH12,
                    initiallyExpanded: true,
                    shape: const Border(),
                    children: [
                      KUserAvatar(
                        imgUrl: user.image,
                        radius: 44.r,
                      ),
                      InnerBoxRowItem(
                        title: "Name",
                        value: user.name,
                      ),
                      gap6,
                      InnerBoxRowItem(
                        title: "Phone",
                        value: user.phone,
                      ),
                      gap6,
                      InnerBoxRowItem(
                        title: "Address",
                        value: user.address,
                      ),
                      gap6,
                      InnerBoxRowItem(
                        title: "Email",
                        value: user.email,
                      ),
                      gap12,
                    ],
                  ),
                ],
              ),
            ),
            gap16,
            //. Order Status & Address

            ContainerBGWhiteSlideFromRight(
              borderColor: context.colors.secondaryContainer.withOpacity(.2),
              bgColor: AppColors.bg100,
              // padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  const InnerBoxRowItem(
                    title: "Serial ID",
                    value: "231123-PB6CB3-004-Tangail",
                  ),
                  gap6,
                  const InnerBoxRowItem(
                    title: "Grand Total",
                    value: "10000",
                  ),
                ],
              ),
            ),
            gap16,
          ],
        ),
      ),
    );
  }
}

class InnerBoxRowItem extends StatelessWidget {
  const InnerBoxRowItem({
    super.key,
    required this.title,
    required this.value,
    this.total = false,
  });

  final String title;
  final String value;
  final bool total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.titleMedium!.copyWith(
            fontSize: total ? 16.sp : 12.sp,
            fontWeight: total ? FontWeight.bold : null,
          ),
        ),
        Text(
          value,
          style: context.titleMedium!.copyWith(
            fontSize: total ? 16.sp : 12.sp,
            fontWeight: total ? FontWeight.bold : null,
          ),
        ),
      ],
    );
  }
}
