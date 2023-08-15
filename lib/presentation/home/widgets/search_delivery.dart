import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class SearchDelivery extends HookWidget {
  const SearchDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    final searchTextController = useTextEditingController();
    return Row(
      children: [
        Flexible(
          child: KTextFormField2(
            controller: searchTextController,
            hintText: AppStrings.shippingNumber,
            hintTextStyle: CustomTextStyle.textStyle14w500B800,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
              ),
            ),
          ),
        ),
        gap16,
        SizedBox(
          width: 60.w,
          height: 50.h,
          child: KFilledButton(
            onPressed: () {},
            text: '',
            // size: Size(60, 50.h),
            padding: padding0,
            backgroundColor: ColorPalate.primary300,
            child: const Icon(
              Icons.qr_code_scanner,
              color: ColorPalate.bg200,
            ),
          ),
        ),
      ],
    ).p(16.w);
  }
}
