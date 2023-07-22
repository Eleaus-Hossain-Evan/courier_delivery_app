import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../application/auth/auth_provider.dart';
import '../../application/home/home_provider.dart';
import '../../utils/utils.dart';
import '../widgets/widgets.dart';
import 'widgets/search_delivery.dart';
import 'widgets/working_summery.dart';

class HomeScreen extends HookConsumerWidget {
  static String route = "/home";
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final state = ref.watch(homeProvider);
    final authState = ref.watch(authProvider);

    ref.listen(homeProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        BotToast.showLoading();
      }
      if (previous.loading == true && next.loading == false) {
        BotToast.closeAllLoading();
      }
    });

    useEffect(() {
      Future.wait([
        // Future.microtask(() => ref.read(carServiceProvider.notifier).getYear()),
        // Future.microtask(
        //     () => ref.read(carServiceProvider.notifier).getAllProblems()),
      ]);
      return null;
    }, []);

    //f53d2d

    return Scaffold(
      appBar: KAppBar(
        title: Column(
          crossAxisAlignment: crossStart,
          children: [
            Text(
              "Evan",
              style: CustomTextStyle.textStyle14w600B600.copyWith(
                color: ColorPalate.secondary200,
              ),
            ),
            Text(
              AppStrings.welcome(""),
              style: CustomTextStyle.textStyle18w600HG1000,
            ),
          ],
        ),
        leading: Padding(
          padding: EdgeInsets.all(4.w),
          child: KCircleAvatar(
            imgUrl: "https://i.pravatar.cc/300",
            enableBorder: true,
            radius: 20.r,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Badge(
              isLabelVisible: state.notification,
              child: const Icon(Icons.notifications_outlined),
            ),
          )
        ],
      ),
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: SingleChildScrollView(
          controller: scrollController,
          padding: padding16,
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              const WorkingSummery(),
              gap24,
              const SearchDelivery(),
              gap24,
              Row(
                mainAxisAlignment: mainSpaceBetween,
                children: [
                  "Today's Deliveries"
                      .text
                      .bold
                      .lg
                      .color(ColorPalate.black900)
                      .make(),
                  "View all"
                      .text
                      .color(ColorPalate.secondary200)
                      .make()
                      .pSymmetric(h: 4, v: 2)
                      .onInkTap(() {})
                ],
              ),
              gap24,
              ListTile(
                title: "Evan Hossain".text.make(),
                subtitle: "Dhaka, Bangladesh".text.make(),
                // leading: KCircleAvatar(
                //   imgUrl: "https://i.pravatar.cc/300",
                //   enableBorder: true,
                //   radius: 30.r,
                // ),
                leading: const CircleAvatar(
                  backgroundImage: AssetImage(Images.deliveryBox),
                ),
                trailing: const Icon(Icons.details)
                    .iconColor(ColorPalate.secondary200)
                    .rotate90(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
