import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:courier_delivery_app/rider/domain/top_level_rider_parcel_model.dart';

import '../../../../utils/utils.dart';
import 'parcel_action_section.dart';
import 'parcel_customer_info_section.dart';
import 'parcel_product_detail_section.dart';
import 'parcel_reguler_info_section.dart';
import 'parcel_top_section.dart';

class ParcelRiderDetailWidget extends HookConsumerWidget {
  const ParcelRiderDetailWidget({
    super.key,
    required this.model,
    required this.pageType,
  });

  final TopLevelRiderParcelModel model;
  final ParcelRiderType pageType;
  
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

    Logger.d(model);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: crossStart,
          mainAxisSize: mainMin,
          children: [
            ParcelTopSection(model: model),
            gap16,
            ParcelCustomerInfoSection(model: model),
            gap16,
            ParcelRegularInfoSection(model: model),
            gap16,
            ParcelProductDetailSection(
              model: model,
              isUndo: isUndo.value,
            ),
            gap16,
            ParcelActionSection(
              model: model,
              pageType: pageType,
              onUndoTap: (p0) => isUndo.value = p0,
            ),
            gap16,
          ],
        ),
      ),
    );
  }
}
