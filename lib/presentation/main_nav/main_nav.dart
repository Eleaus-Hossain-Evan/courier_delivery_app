import 'package:courier_delivery_app/presentation/delivery/delivery_screen.dart';
import 'package:courier_delivery_app/presentation/earning/earning_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/utils.dart';
import '../cart/cart_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

final bottomNavigatorKey = GlobalKey();

class MainNav extends HookConsumerWidget {
  static const route = '/main_nav';

  const MainNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authState = ref.watch(authProvider);
    // final user = ref.watch(loggedInProvider);

    final navIndex = useState(0);
    final navWidget = [
      const HomeScreen(),
      const DeliveryScreen(),
      const EarningScreen(),
      const ProfileScreen(),
    ];

    useEffect(() {
      Future.wait([
        // Future.microtask(() => ref.read(homeProvider.notifier).getHomeData()),
      ]);

      // Future.microtask(() => ref.read(homeProvider.notifier).getHomeData());

      // Future.microtask(
      //     () => ref.read(categoryProvider.notifier).fetchAllCategories());
      // ref.watch(loggedInProvider).isLoggedIn
      //     ? Future.microtask(() => ref.read(cartProvider.notifier).fetchCart())
      //     : null;
      // Future.microtask(() =>
      //     ref.read(instructorProvider.notifier).fetchAllFeaturedInstructors());
      return null;
    }, []);

    return LayoutBuilder(builder: (context, constrain) {
      // Logger.i("constrain: $constrain");
      return Scaffold(
        body: navWidget[navIndex.value],
        bottomNavigationBar: NavigationBar(
          backgroundColor: ColorPalate.bg200,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          key: bottomNavigatorKey,
          selectedIndex: navIndex.value,
          onDestinationSelected: (index) {
            navIndex.value = index;
          },
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          // selectedFontSize: 10.sp,
          // unselectedFontSize: 10.sp,
          // selectedItemColor: context.color.primary,
          // unselectedItemColor: ColorPalate.black,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home_filled,
                color: navIndex.value == 0
                    ? context.color.primary
                    : ColorPalate.black600,
              ),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.delivery_dining,
                color: navIndex.value == 1
                    ? context.color.primary
                    : ColorPalate.black600,
              ),
              label: "Delivery",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.currency_exchange_rounded,
                color: navIndex.value == 2
                    ? context.color.primary
                    : ColorPalate.black600,
              ),
              label: "Earning",
            ),
            NavigationDestination(
              icon: Icon(
                Icons.account_box_rounded,
                color: navIndex.value == 3
                    ? context.color.primary
                    : ColorPalate.black600,
              ),
              label: "Profile",
            ),
          ],
        ).box.shadowSm.make(),
      );
    });
  }
}
