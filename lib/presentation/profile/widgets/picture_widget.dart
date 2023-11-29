import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../application/auth/auth_provider.dart';

import '../../widgets/widgets.dart';

class ProfilePicWidget extends HookConsumerWidget {
  const ProfilePicWidget({
    super.key,
    required this.onEditTap,
  });

  final Function() onEditTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    return KInkWell(
      onTap: onEditTap,
      borderRadius: radius16,
      child: Container(
        padding: padding20,
        decoration: BoxDecoration(
          color: ColorPalate.bg100,
          borderRadius: radius16,
        ),
        child: Row(
          children: [
            KUserAvatar(
              radius: 36.w,
              enableBorder: true,
            ),
            gap16,
            Column(
              crossAxisAlignment: crossStart,
              children: [
                Text(
                  state.user.name,
                  style: CustomTextStyle.textStyle16w600,
                ),
                gap4,
                Text(
                  state.user.email,
                  maxLines: 2,
                  style: CustomTextStyle.textStyle12w500B800,
                ),
                gap4,
                Text(
                  state.user.phone,
                  style: CustomTextStyle.textStyle12w500B800,
                ),
              ],
            ).expand(),
            Icon(
              Icons.chevron_right_rounded,
              size: 28.sp,
              color: ColorPalate.black,
            ),
          ],
        ),
      ),
    );
  }
}
