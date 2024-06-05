import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';

class ParcelProductDetailSection extends StatelessWidget {
  const ParcelProductDetailSection({
    super.key,
    required this.details,
    required this.note,
    required this.isUndo,
  });

  final String details;
  final String note;
  final bool isUndo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        Visibility(
          visible: details.isNotEmptyAndNotNull,
          replacement: Text.rich(
            'Parcel Detail:  '
                .textSpan
                .withChildren([
                  'No Detail added...'.textSpan.semiBold.make(),
                ])
                .bodySmall(context)
                .letterSpacing(.8)
                .make(),
          ),
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              Row(
                mainAxisAlignment: mainStart,
                children: [
                  Icon(
                    BoxIcons.bx_detail,
                    size: 8.sp,
                  ).circle(
                    radius: 16,
                    backgroundColor: context.colors.surface,
                    border: Border.all(color: AppColors.black700),
                  ),
                  gap4,
                  'Parcel Details'
                      .text
                      .bodySmall(context)
                      .base
                      .bold
                      .letterSpacing(.8)
                      .makeCentered(),
                ],
              ),
              details.text.lg
                  .letterSpacing(.8)
                  .make()
                  .pSymmetric(h: 16.w, v: 8.w),
            ],
          ),
        ),
        Visibility(
          visible: !isUndo,
          child: Visibility(
            visible: note.isNotEmptyAndNotNull,
            replacement: Text.rich(
              'Note:  '
                  .textSpan
                  .withChildren([
                    'No Note yet...'.textSpan.bodySmall(context).make(),
                  ])
                  .bodySmall(context)
                  .letterSpacing(.8)
                  .make(),
            ),
            child: Column(
              crossAxisAlignment: crossStart,
              children: [
                Row(
                  mainAxisAlignment: mainStart,
                  children: [
                    Icon(
                      BoxIcons.bx_note,
                      size: 8.sp,
                    ).circle(
                      radius: 16,
                      backgroundColor: context.colors.surface,
                      border: Border.all(color: AppColors.black700),
                    ),
                    gap4,
                    'Note'
                        .text
                        .bodySmall(context)
                        .base
                        .bold
                        .letterSpacing(.8)
                        .makeCentered(),
                  ],
                ),
                note.text.lg
                    .letterSpacing(.8)
                    .make()
                    .pSymmetric(h: 16.w, v: 8.w),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
