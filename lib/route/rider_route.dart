import 'package:go_router/go_router.dart';

import '../presentation/main_nav/main_nav.dart';

List<GoRoute> riderRoute = [
  GoRoute(
    path: MainNavRider.route,
    builder: (context, state) => const MainNavRider(),
  ),
];
