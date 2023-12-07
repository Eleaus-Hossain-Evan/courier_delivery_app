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
      backgroundColor: AppColors.bg100,
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
              bgColor: AppColors.bg200,
              padding: padding0,
              child: ListTile(
                title: const Text(
                  "Today's Parcel",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Total Parcel: 10",
                  style: context.bodySmall,
                ),
                trailing: Text(
                  "\$10,000",
                  style: context.labelSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            gap16,

            ContainerBGWhiteSlideFromRight(
              bgColor: AppColors.bg100,
              padding: padding0,
              child: Column(
                crossAxisAlignment: crossStart,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.w,
                    ),
                    child: Text(
                      "Summery",
                      style: context.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ExpansionTile(
                    title: Text(
                      "Total assigned Parcel: 10",
                      style: context.bodySmall,
                    ),
                    subtitle: Text(
                      "${AppStrings.tkSymbol}10,000",
                      style: context.labelSmall,
                    ),
                    tilePadding: paddingH16,
                    childrenPadding: paddingH12,
                    initiallyExpanded: true,
                    shape: const Border(),
                    children: const [
                      _ParcelItemTile(
                        index: 1,
                        title: "231123-PB6CB3-004-Tangail",
                        value: "800",
                        status: ParcelRiderType.complete,
                      ),
                      _ParcelItemTile(
                        index: 2,
                        title: "231123-PB6CB3-004-Tangail",
                        value: "500",
                        status: ParcelRiderType.reject,
                      ),
                      _ParcelItemTile(
                        index: 3,
                        title: "231123-PB6CB3-004-Tangail",
                        value: "1000",
                        status: ParcelRiderType.complete,
                      ),
                      _ParcelItemTile(
                        index: 4,
                        title: "231123-PB6CB3-004-Tangail",
                        value: "800",
                        status: ParcelRiderType.complete,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const _ParcelItemTile(
              index: 5,
              title: "231123-PB6CB3-004-Tangail",
              value: "500",
              status: ParcelRiderType.reject,
            ),
            gap16,
            //. Order Status & Address

            ContainerBGWhiteSlideFromRight(
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

class _ParcelItemTile extends StatelessWidget {
  const _ParcelItemTile({
    required this.index,
    required this.title,
    required this.value,
    required this.status,
  });

  final int index;
  final String title;
  final String value;
  final ParcelRiderType status;

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      return switch (status) {
        ParcelRiderType.complete => context.theme.primaryColor,
        ParcelRiderType.reject => context.colors.error,
        _ => AppColors.secondary200,
      };
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.bg200,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        onTap: () {},
        title: Text.rich(
          TextSpan(
            text: "$index#",
            children: [
              TextSpan(
                text: " ",
                style: context.labelSmall,
              ),
              TextSpan(
                text: title,
                style: context.labelSmall,
              ),
            ],
          ),
          style: context.labelSmall!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${AppStrings.tkSymbol}$value",
          style: context.labelSmall,
        ),
        trailing: SizedBox(
          height: 28.w,
          child: Chip(
            backgroundColor: getColor(),
            shape: const StadiumBorder(),
            side: BorderSide.none,
            // labelPadding: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            label: Text(
              status.name.toWordTitleCase(),
              style: TextStyle(
                color: AppColors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: .8,
              ),
            ),
          ),
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
