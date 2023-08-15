import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../application/auth/auth_provider.dart';
import '../../../../application/global.dart';
import '../../../../presentation/widgets/widgets.dart';
import '../../../../utils/utils.dart';

class ProfilePicWidget extends HookConsumerWidget {
  const ProfilePicWidget({
    Key? key,
    required this.onEditTap,
  }) : super(key: key);

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
                  style: CustomTextStyle.textStyle14w400,
                ),
                gap4,
                Text(
                  ref.watch(appLocalProvider).languageCode == 'en'
                      ? state.user.phone
                      : int.parse(state.user.phone).toArabicDigits(),
                  style: CustomTextStyle.textStyle14w400B800,
                ),
              ],
            ),
            const Spacer(),
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
