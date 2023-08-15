import 'package:go_router/go_router.dart';

import '../pickup_man/presentation/main_nav_pickup/main_nav_pickup.dart';

List<GoRoute> pickupRoute = [
  GoRoute(
    path: MainNavPickupMan.route,
    builder: (context, state) => const MainNavPickupMan(),
  ),
];
