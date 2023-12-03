import 'package:courier_delivery_app/application/global.dart';
import 'package:courier_delivery_app/infrastructure/dashboard_repo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/dashboard/dashboard_model.dart';
import '../../utils/utils.dart';
import '../auth/auth_provider.dart';

part 'dashboard_provider.g.dart';

// @riverpod
// class Dashboard extends _$Dashboard {
//   final repo = DashboardRepo();

//   Future<DashboardModel> _fetch(bool isPickup) async {
//     final result = await repo.getDashboard(isPickup: isPickup);

//     return result.fold((l) {
//       showErrorToast(l.error.message);
//       return DashboardModel.init();
//     }, (r) => r.data);
//   }

//   @override
//   Future<DashboardModel> build(bool isPickup) async {
//     return _fetch(isPickup);
//   }
// }

@riverpod
FutureOr<DashboardModel> dashboard(DashboardRef ref) async {
  final isPickup = ref.watch(roleProvider) == Role.pickupman;

  final result =
      await ref.read(dashboardRepoProvider).getDashboard(isPickup: isPickup);

  return result.fold((l) {
    showErrorToast(l.error.message);
    return DashboardModel.init();
  }, (r) => r.data);
}
