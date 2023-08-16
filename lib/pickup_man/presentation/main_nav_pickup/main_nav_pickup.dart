import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../presentation/profile/profile_screen.dart';
import '../../../utils/utils.dart';
import '../history/history_screen.dart';
import '../home_pickup/home_screen_pickup.dart';
import '../pickup_list/delivery_screen.dart';

final bottomNavigatorKeyPickup = GlobalKey();

class MainNavPickupMan extends HookConsumerWidget {
  static const route = '/main-nav-pickup-man';

  const MainNavPickupMan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navIndex = useState(0);
    final navWidget = [
      const HomeScreenPickup(),
      const PickUpListScreen(),
      const HistoryScreen(),
      const ProfileScreen(),
    ];

    return LayoutBuilder(builder: (context, constrain) {
      return Scaffold(
        body: navWidget[navIndex.value],
        bottomNavigationBar: NavigationBar(
          backgroundColor: ColorPalate.bg200,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          key: bottomNavigatorKeyPickup,
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
                    : ColorPalate.black600,
              ),
              label: AppStrings.home,
            ),
            NavigationDestination(
              icon: Icon(
                FontAwesome.boxes_packing,
                color: navIndex.value == 1
                    ? context.colors.primary
                    : ColorPalate.black600,
              ),
              label: AppStrings.pickup,
            ),
            NavigationDestination(
              icon: Icon(
                FontAwesome.list_check,
                color: navIndex.value == 1
                    ? context.colors.primary
                    : ColorPalate.black600,
              ),
              label: AppStrings.history,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.account_box_rounded,
                color: navIndex.value == 3
                    ? context.colors.primary
                    : ColorPalate.black600,
              ),
              label: AppStrings.profile,
            ),
          ],
        ).box.shadowSm.make(),
      );
    });
  }
}
