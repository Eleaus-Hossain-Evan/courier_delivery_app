import 'package:go_router/go_router.dart';

import '../rider/presentation/main_nav/main_nav_rider.dart';

List<GoRoute> riderRoute = [
  GoRoute(
    path: MainNavRider.route,
    builder: (context, state) => const MainNavRider(),
  ),
];
