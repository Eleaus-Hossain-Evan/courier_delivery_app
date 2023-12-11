import 'dart:async';

import 'package:courier_delivery_app/domain/parcel/model/merchant_info_model.dart';
import 'package:courier_delivery_app/presentation/widgets/parcel_detail/parcel_merchant_info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:courier_delivery_app/rider/domain/top_level_rider_parcel_model.dart';

import '../../../../utils/utils.dart';
import 'parcel_action_section.dart';
import 'parcel_customer_info_section.dart';
import 'parcel_product_detail_section.dart';
import 'parcel_regular_info_section.dart';
import 'parcel_top_section.dart';

class ParcelRiderDetailWidget extends HookConsumerWidget {
  const ParcelRiderDetailWidget({
    super.key,
    required this.model,
    required this.pageType,
    this.inEarning = false,
  });

  final TopLevelRiderParcelModel model;
  final ParcelRiderType pageType;
  final bool inEarning;

  @override
  Widget build(BuildContext context, ref) {
    final isReceived = useState(false);
    final isCanceled = useState(false);
    final isUndo = useState(isReceived.value || isCanceled.value);

    useEffect(() {
      Future.wait([
        Future.microtask(
            () => isReceived.value = model.status == ParcelRiderType.complete),
        Future.microtask(
            () => isCanceled.value = model.status == ParcelRiderType.reject),
      ]);
      return null;
    }, []);

    // Logger.d(model);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: crossStart,
          mainAxisSize: mainMin,
          children: [
            ParcelTopSection(model: model),
            gap16,
            ParcelCustomerInfoSection(customer: model.parcel.customerInfo),
            gap16,
            const ParcelMerchantInfoSection(
              merchant: MerchantInfoModel(
                  address: "this is the merchant address",
                  shopAddress: "Road 8/C, Nikujo -1, Khilkhet, Dhaka",
                  name: "Merchant 1",
                  phone: "01999999999",
                  shopName: "Shop - 1"),
            ),
            gap16,
            ParcelRegularInfoSection(
              regularParcel: model.parcel.regularParcelInfo,
              createdAt: model.createdAt,
            ),
            gap16,
            ParcelProductDetailSection(
              details: model.parcel.regularParcelInfo.details,
              note: model.note,
              isUndo: isUndo.value,
            ),
            gap16,
            Visibility(
              visible: !inEarning,
              child: ParcelActionSection(
                model: model,
                pageType: pageType,
                onUndoTap: (p0) => isUndo.value = p0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
