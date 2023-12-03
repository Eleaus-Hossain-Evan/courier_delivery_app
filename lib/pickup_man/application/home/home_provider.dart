import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/home_pickup_repo.dart';
import 'home_state.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(HomePickupRepo(), ref);
}, name: "homeProvider");

class HomeNotifier extends StateNotifier<HomeState> {
  final HomePickupRepo repo;
  final Ref ref;

  HomeNotifier(this.repo, this.ref) : super(HomeState.init());

  void removeNotificationBadge() {
    state = state.copyWith(notification: false);
  }

  // void getHomeData() async {
  //   state = state.copyWith(loading: true);
  //   final result = await repo.getHomeDate();

  //   Logger.d("result: $result");
  //   result.fold(
  //     (l) {
  //       showErrorToast(l.error.message);
  //       return state = state.copyWith(failure: l, loading: false);
  //     },
  //     (r) => state = state.copyWith(homeData: r.data, loading: false),
  //   );
  // }
}
