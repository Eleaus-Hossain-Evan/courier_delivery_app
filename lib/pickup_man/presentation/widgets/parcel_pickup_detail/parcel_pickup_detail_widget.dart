import 'dart:async';

import 'package:courier_delivery_app/presentation/widgets/k_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../presentation/widgets/widgets.dart';
import '../../../../utils/utils.dart';
import '../../../domain/parcel/model/top_level_pickup_parcel_model.dart';
import 'widgets/parcel_detail_action.dart';
import 'widgets/parcel_merchant_info_section.dart';
import 'widgets/parcel_product_detail_section.dart';
import 'widgets/parcel_reguler_info_section.dart';
import 'widgets/topbar.dart';

class ParcelPickupDetailWidget extends HookConsumerWidget {
  const ParcelPickupDetailWidget({
    super.key,
    required this.model,
    required this.onTapReceive,
    required this.onTapCancel,
  });

  final TopLevelPickupParcelModel model;

  final FutureOr<bool>? Function(String) onTapReceive;
  final FutureOr<bool>? Function(String) onTapCancel;

  @override
  Widget build(BuildContext context, ref) {
    final isReceived = useState(false);
    final isCanceled = useState(false);
    final isUndo = useState(isReceived.value || isCanceled.value);

    useEffect(() {
      Future.wait([
        Future.microtask(() =>
            isReceived.value = model.status == ParcelPickupStatus.received),
        Future.microtask(
            () => isCanceled.value = model.status == ParcelPickupStatus.cancel),
      ]);
      return null;
    }, []);

    Color getColor() {
      return model.status == ParcelPickupStatus.received
          ? context.theme.primaryColor
          : model.status == ParcelPickupStatus.cancel
              ? context.colors.error
              : context.colors.secondary;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: crossStart,
        // mainAxisSize: mainMin,
        children: [
          TopBar(model: model),
          gap16,
          model.status.name.capitalized.text.lg
              .color(getColor())
              .bold
              .letterSpacing(.8)
              .makeCentered()
              .pSymmetric(h: 12.w, v: 6.h)
              .box
              .roundedSM
              .color(getColor().withOpacity(.05))
              .border(color: getColor().withOpacity(.4))
              .make(),
          gap16,
          ParcelRegularInfoSection(model: model),
          gap16,
          ParcelProductDetailSection(model: model),
          gap16,
          ParcelMerchantInfoSection(model: model),
          gap16,
          ParcelDetailAction(
            model: model,
            isUndo: isUndo,
            onTapCancel: onTapCancel,
            onTapReceive: onTapReceive,
          ),
          gap16,
        ],
      ),
    );
  }
}
