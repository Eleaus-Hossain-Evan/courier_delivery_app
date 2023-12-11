import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../presentation/widgets/widgets.dart';
import '../../../utils/utils.dart';
import '../../domain/top_level_rider_parcel_model.dart';

class EarningDetailScreen extends HookConsumerWidget {
  static const route = '/earning-detail';

  const EarningDetailScreen({
    super.key,
    required this.id,
  });

  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            //. Summery

            ContainerBGWhiteSlideFromRight(
              bgColor: AppColors.bg200,
              padding: padding0,
              child: ExpansionTile(
                title: Text(
                  "Summery",
                  style: context.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                initiallyExpanded: true,
                children: const [
                  SummeryItemTile(
                    title: "Total Assigned Parcel: 10",
                    value: "10000",
                  ),
                  SummeryItemTile(
                    title: "Total Received Parcel: 8",
                    value: "8000",
                  ),
                  SummeryItemTile(
                    title: "Total Dropoff Parcel: 4",
                    value: "5000",
                    valueColor: AppColors.primary300,
                  ),
                  SummeryItemTile(
                    title: "Total Returned Parcel: 3",
                    value: "120",
                    valueColor: AppColors.error,
                  ),
                  SummeryItemTile(
                    title: "Total Hold Parcel: 1",
                    value: "",
                  ),
                ],
              ),
            ),

            gap16,

            ContainerBGWhiteSlideFromRight(
              bgColor: AppColors.bg200,
              padding: padding0,
              child: Column(
                crossAxisAlignment: crossStart,
                children: [
                  //. Total Parcel

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
                    shape: const Border(),
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: paddingBottom16,
                        itemBuilder: (context, index) => _ParcelItemTile(
                          index: index + 1,
                          title: "231123-PB6CB3-004-Tangail",
                          value: "800",
                          status: index % 2 == 0
                              ? ParcelRiderType.complete
                              : ParcelRiderType.reject,
                        ),
                        separatorBuilder: (context, index) => gap12,
                        itemCount: 10,
                      )
                    ],
                  ),

                  //. Received Parcel

                  ExpansionTile(
                    title: Text(
                      "Received Parcel: 8",
                      style: context.bodySmall,
                    ),
                    subtitle: Text(
                      "${AppStrings.tkSymbol}8,000",
                      style: context.labelSmall,
                    ),
                    tilePadding: paddingH16,
                    childrenPadding: paddingH12,
                    shape: const Border(),
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: paddingBottom16,
                        itemBuilder: (context, index) => _ParcelItemTile(
                          index: index + 1,
                          title: "231123-PB6CB3-004-Tangail",
                          value: "800",
                          status: index % 2 == 0
                              ? ParcelRiderType.complete
                              : ParcelRiderType.reject,
                        ),
                        separatorBuilder: (context, index) => gap12,
                        itemCount: 8,
                      )
                    ],
                  ),

                  //. dropoff Parcel

                  ExpansionTile(
                    title: Text(
                      "Dropoff Parcel: 5",
                      style: context.bodySmall,
                    ),
                    subtitle: Text(
                      "${AppStrings.tkSymbol}6,000",
                      style: context.labelSmall,
                    ),
                    tilePadding: paddingH16,
                    childrenPadding: paddingH12,
                    shape: const Border(),
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: paddingBottom16,
                        itemBuilder: (context, index) => _ParcelItemTile(
                          index: index + 1,
                          title: "231123-PB6CB3-004-Tangail",
                          value: "800",
                          status: index % 2 == 0
                              ? ParcelRiderType.complete
                              : ParcelRiderType.reject,
                        ),
                        separatorBuilder: (context, index) => gap12,
                        itemCount: 5,
                      )
                    ],
                  ),

                  //. return Parcel

                  ExpansionTile(
                    title: Text(
                      "Return Parcel: 3",
                      style: context.bodySmall,
                    ),
                    subtitle: Text(
                      "${AppStrings.tkSymbol}120",
                      style: context.labelSmall,
                    ),
                    tilePadding: paddingH16,
                    childrenPadding: paddingH12,
                    shape: const Border(),
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: paddingBottom16,
                        itemBuilder: (context, index) => _ParcelItemTile(
                          index: index + 1,
                          title: "231123-PB6CB3-004-Tangail",
                          value: "800",
                          status: index % 2 == 0
                              ? ParcelRiderType.complete
                              : ParcelRiderType.reject,
                        ),
                        separatorBuilder: (context, index) => gap12,
                        itemCount: 3,
                      )
                    ],
                  ),

                  //. Hold Parcel

                  ExpansionTile(
                    title: Text(
                      "Hold Parcel: 1",
                      style: context.bodySmall,
                    ),
                    // subtitle: Text(
                    //   "${AppStrings.tkSymbol}6,000",
                    //   style: context.labelSmall,
                    // ),
                    tilePadding: paddingH16,
                    childrenPadding: paddingH12,
                    shape: const Border(),
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: paddingBottom16,
                        itemBuilder: (context, index) => _ParcelItemTile(
                          index: index + 1,
                          title: "231123-PB6CB3-004-Tangail",
                          value: "800",
                          status: index % 2 == 0
                              ? ParcelRiderType.complete
                              : ParcelRiderType.reject,
                        ),
                        separatorBuilder: (context, index) => gap12,
                        itemCount: 1,
                      )
                    ],
                  ),
                ],
              ),
            ),

            gap16,
            //. Order Status & Address

            // ContainerBGWhiteSlideFromRight(
            //   bgColor: AppColors.bg200,
            //   // padding: EdgeInsets.symmetric(horizontal: 20.w),
            //   child: Column(
            //     children: [
            //       const InnerBoxRowItem(
            //         title: "Serial ID",
            //         value: "231123-PB6CB3-004-Tangail",
            //       ),
            //       gap6,
            //       const InnerBoxRowItem(
            //         title: "Grand Total",
            //         value: "10000",
            //       ),
            //     ],
            //   ),
            // ),
            gap16,
          ],
        ),
      ),
    );
  }
}

class SummeryItemTile extends StatelessWidget {
  const SummeryItemTile({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
  });

  final String title;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: paddingH16,
      title: Text(
        title,
        style: context.bodySmall,
      ),
      trailing: value.isEmpty
          ? null
          : Text(
              "\$$value",
              style: context.labelSmall!
                  .copyWith(fontWeight: FontWeight.bold, color: valueColor),
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

    return ListTile(
      contentPadding: paddingH12,
      dense: true,
      onTap: () {
        kShowBarModalBottomSheet(
          context: context,
          child: ParcelRiderDetailWidget(
            model: model,
            pageType: ParcelRiderType.all,
            inEarning: true,
          ),
        );
      },
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

final model = TopLevelRiderParcelModel.fromJson("""
{
            "_id": "656c293cebcc61624a0eee5e",
            "isComplete": false,
            "cashCollected": 600,
            "note": "done...",
            "parcelStatus": "dropoff",
            "status": "complete",
            "statusHistory": [
                {
                    "time": "2023-12-03T07:07:40.810Z",
                    "_id": "656c293cebcc61624a0eee5f",
                    "statusBy": "Hadiuzzaman(01671849365)",
                    "status": "assign"
                },
                {
                    "time": "2023-12-04T09:05:33.007Z",
                    "_id": "656d965d662b676bb0523b5f",
                    "statusBy": "undefined(01860955065)",
                    "status": "complete"
                },
                {
                    "time": "2023-12-04T09:44:06.377Z",
                    "_id": "656d9f6612a38aa722fa4f66",
                    "statusBy": "undefined(01860955065)",
                    "status": "complete"
                },
                {
                    "time": "2023-12-04T09:52:56.407Z",
                    "_id": "656da17812a38aa722fa4f8b",
                    "statusBy": "undefined(01860955065)",
                    "status": "complete"
                },
                {
                    "time": "2023-12-04T10:24:11.835Z",
                    "_id": "656da8cb532f10a71205df2d",
                    "statusBy": "undefined(01860955065)",
                    "status": "complete"
                },
                {
                    "time": "2023-12-04T10:27:56.425Z",
                    "_id": "656da9ac12a38aa722fa4f9e",
                    "statusBy": "undefined(01860955065)",
                    "status": "complete"
                },
                {
                    "time": "2023-12-04T10:41:27.666Z",
                    "_id": "656dacd7532f10a71205df32",
                    "statusBy": "undefined(01860955065)",
                    "status": "complete"
                },
                {
                    "time": "2023-12-04T10:41:46.699Z",
                    "_id": "656dacea12a38aa722fa4fa2",
                    "statusBy": "undefined(01860955065)",
                    "status": "complete"
                },
                {
                    "time": "2023-12-04T10:42:30.078Z",
                    "_id": "656dad16532f10a71205df34",
                    "statusBy": "undefined(01860955065)",
                    "status": "complete"
                },
                {
                    "time": "2023-12-04T10:42:50.288Z",
                    "_id": "656dad2a12a38aa722fa4fa4",
                    "statusBy": "undefined(01860955065)",
                    "status": "complete"
                }
            ],
            "createdAt": "2023-12-03T07:07:40.836Z",
            "updatedAt": "2023-12-04T10:42:50.289Z",
            "__v": 0,
            "parcel": {
                "_id": "655eff1b0d5e6b181bf38690",
                "regularParcelInfo": {
                    "invoiceId": "8",
                    "weight": "1kg",
                    "productPrice": 500,
                    "materialType": "regular",
                    "category": "",
                    "details": "Fast Delivery ",
                    "instruction": "Fast Delivery "
                },
                "regularPayment": {
                    "cashCollection": 600,
                    "deliveryCharge": 100,
                    "codCharge": 6,
                    "weightCharge": 30,
                    "totalCharge": 136
                },
                "riderStatus": "assign",
                "serialId": "231123-PB6CB3-004-Tangail",
                "customerInfo": {
                    "name": "Hadi",
                    "phone": "01956945289",
                    "address": "Tangail",
                    "district": {
                        "_id": "642e4713912a102364a618f1",
                        "name": "Tangail"
                    },
                    "area": {
                        "_id": "64ef2c46b01c421d79c9078a",
                        "name": "Tangail Sadar"
                    }
                }
            }
        }
""");
