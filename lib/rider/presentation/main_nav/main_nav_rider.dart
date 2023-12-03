import 'package:courier_delivery_app/presentation/delivery/delivery_screen.dart';
import 'package:courier_delivery_app/rider/presentation/earning/earning_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/utils.dart';
import '../home/home_screen_rider.dart';
import '../../../presentation/profile/profile_screen.dart';

final bottomNavigatorKey = GlobalKey();

class MainNavRider extends HookConsumerWidget {
  static const route = '/main-nav-rider';

  const MainNavRider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navIndex = useState(0);
    final navWidget = [
      const HomeScreenRider(),
      const DeliveryScreen(),
      const EarningScreen(),
      const ProfileScreen(),
    ];

    return LayoutBuilder(builder: (context, constrain) {
      return Scaffold(
        body: navWidget[navIndex.value],
        bottomNavigationBar: NavigationBar(
          backgroundColor: AppColors.bg200,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          key: bottomNavigatorKey,
          selectedIndex: navIndex.value,
          onDestinationSelected: (index) {
            navIndex.value = index;
          },
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home_filled,
                color: navIndex.value == 0
                    ? context.colors.primary
                    : AppColors.black600,
              ),
              label: AppStrings.home,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.delivery_dining,
                color: navIndex.value == 1
                    ? context.colors.primary
                    : AppColors.black600,
              ),
              label: AppStrings.delivery,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.currency_exchange_rounded,
                color: navIndex.value == 2
                    ? context.colors.primary
                    : AppColors.black600,
              ),
              label: AppStrings.earning,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.account_box_rounded,
                color: navIndex.value == 3
                    ? context.colors.primary
                    : AppColors.black600,
              ),
              label: AppStrings.profile,
            ),
          ],
        ).box.shadowSm.make(),
      );
    });
  }
}
