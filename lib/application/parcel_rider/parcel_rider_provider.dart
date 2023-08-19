import 'package:courier_delivery_app/domain/parcel/model/top_level_rider_parcel_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:courier_delivery_app/application/parcel_rider/parcel_rider_state.dart';
import 'package:courier_delivery_app/infrastructure/parcel_rider_repo.dart';

import '../global.dart';

final parcelRiderProvider =
    StateNotifierProvider<ParcelRiderNotifier, ParcelRiderState>((ref) {
  return ParcelRiderNotifier(ref, ParcelRiderRepo());
}, name: 'parcelRiderNotifierProvider');

class ParcelRiderNotifier extends StateNotifier<ParcelRiderState> {
  final Ref ref;
  final ParcelRiderRepo repo;
  ParcelRiderNotifier(this.ref, this.repo) : super(ParcelRiderState.init());

  Future<bool> parcelPickupList({
    ParcelRiderType type = ParcelRiderType.all,
    int page = 1,
    int limit = 10,
    bool isComplete = false,
  }) async {
    var success = false;
    state = state.copyWith(loading: true);

    final result = await repo.getRiderParcelList(
        type: type, page: page, limit: limit, isComplete: false);

    result.fold((l) {
      showErrorToast(l.error.message);

      state = state.copyWith(loading: false);
    }, (r) {
      success = r.success;
      final finalList = [
        ...state.parcelRiderResponse.data,
        ...r.data.map((e) => e.copyWith(isComplete: isComplete))
      ]..removeDuplicates(by: (item) => item.id);

      // finalList.removeDuplicates(by: (item) => item.id);
      // Logger.i(r);
      state = state.copyWith(
          loading: false, parcelRiderResponse: r.copyWith(data: finalList));
    });

    return success;
  }
}
