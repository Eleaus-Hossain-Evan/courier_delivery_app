import 'package:courier_delivery_app/application/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../utils/utils.dart';

class HomeAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(authProvider);

    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "Rider App".text.xl2.bold.gray600.make(),
          Column(
            crossAxisAlignment: crossEnd,
            children: [
              "Hello,".text.xs.bold.make(),
              state.user.name.text.lg.bold.gray500.make(),
            ],
          ),
        ],
      ).pSymmetric(h: 16, v: 8).card.elevation(2).make(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 14.h);
}
