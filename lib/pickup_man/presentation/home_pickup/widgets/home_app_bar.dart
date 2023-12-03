import 'package:courier_delivery_app/application/auth/auth_provider.dart';
import 'package:courier_delivery_app/presentation/notification/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../presentation/widgets/widgets.dart';
import '../../../../utils/utils.dart';

class HomeAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(authProvider);

    return KAppBar(
      title: Column(
        crossAxisAlignment: crossStart,
        children: [
          Text(
            state.user.name,
            style: CustomTextStyle.textStyle18w500Black800.copyWith(
              color: AppColors.primary300,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            AppStrings.welcome(""),
            style: CustomTextStyle.textStyle12w400B800,
          ),
        ],
      ),
      leading: Padding(
        padding: EdgeInsets.all(4.w),
        child: KUserAvatar(
          enableBorder: true,
          radius: 20.r,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).push(NotificationScreen.route);
          },
          icon: const Badge(
            isLabelVisible: true,
            child: Icon(Icons.notifications_outlined),
          ),
        ),
        gap12,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
