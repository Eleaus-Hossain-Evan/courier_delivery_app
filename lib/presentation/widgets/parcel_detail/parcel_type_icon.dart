import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../utils/utils.dart';

class ParcelTypeIcon extends StatelessWidget {
  const ParcelTypeIcon(this.type, {Key? key, this.size = 18}) : super(key: key);

  final ParcelMaterialType type;
  final double size;

  @override
  Widget build(BuildContext context) {
    // regular - Bootstrap.box_seam
    // fragile - BoxIcons.bx_box
    // liquid - BoxIcons.bx_box

    var iconData = switch (type) {
      ParcelMaterialType.regular => Bootstrap.box_seam,
      ParcelMaterialType.fragile => BoxIcons.bx_box,
      ParcelMaterialType.liquid => BoxIcons.bx_water,
      ParcelMaterialType.none => BoxIcons.bx_box,
    };
    return Icon(iconData, size: size.sp);
  }
}
