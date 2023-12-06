import 'package:courier_delivery_app/rider/presentation/earning/earning_detail_screen.dart';
import 'package:go_router/go_router.dart';

import '../rider/presentation/main_nav/main_nav_rider.dart';
import 'go_router.dart';

List<GoRoute> riderRoute = [
  GoRoute(
    path: MainNavRider.route,
    builder: (context, state) => const MainNavRider(),
  ),
  GoRoute(
    path: "${EarningDetailScreen.route}/:id",
    pageBuilder: (context, state) => SlideRightToLeftTransitionPage(
      key: state.pageKey,
      child: EarningDetailScreen(id: state.pathParameters['id']!),
    ),
  ),
];
