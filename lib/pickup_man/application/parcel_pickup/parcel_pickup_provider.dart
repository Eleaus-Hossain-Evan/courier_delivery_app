import 'package:courier_delivery_app/application/global.dart';
import 'package:courier_delivery_app/pickup_man/infrastructure/parcel_pickup_repo.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/parcel/model/top_level_common_parcel_model.dart';
import 'parcel_pickup_state.dart';

final parcelPickupProvider =
    StateNotifierProvider<ParcelPickupNotifier, ParcelPickupState>((ref) {
  return ParcelPickupNotifier(ref, ParcelPickupRepo());
}, name: "parcelPickupProvider");

class ParcelPickupNotifier extends StateNotifier<ParcelPickupState> {
  final Ref ref;
  final ParcelPickupRepo repo;

  ParcelPickupNotifier(this.ref, this.repo) : super(ParcelPickupState.init());

  Future<bool> parcelPickupList({
    ParcelPickupType type = ParcelPickupType.all,
    int page = 1,
    int limit = 10,
  }) async {
    var success = false;
    state = state.copyWith(loading: true);

    final result =
        await repo.getPickupParcelList(type: type, page: page, limit: limit);

    result.fold((l) {
      showErrorToast(l.error.message);

      state = state.copyWith(loading: false);
    }, (r) {
      final preList = state.parcelPickupResponse.data;
      final newList = r.data;
      Logger.i(r);
      state = state.copyWith(
          loading: false,
          parcelPickupResponse: r.copyWith(data: [...preList, ...newList]));
    });

    return success;
  }

  bool handleResponse(int index, int pageSize, int currentPage) {
    final itemPosition = index + 1;
    final requestMoreData = itemPosition % pageSize == 0 && itemPosition != 0;
    final pageToRequest = itemPosition ~/ pageSize;

    if (requestMoreData && pageToRequest + 1 >= currentPage) {
      return true;
    }
    return false;
  }

  Future<bool> updateParcel({
    ParcelPickupType type = ParcelPickupType.all,
    required String id,
  }) async {
    var success = false;
    state = state.copyWith(loading: true);

    final result = await repo.updatePickupParcel(type: type, id: id);

    result.fold((l) {
      showErrorToast(l.error.message);

      state = state.copyWith(loading: false);
    }, (r) {
      Logger.i(r);

      final parcelList = state.parcelPickupResponse.data.lock
        ..where((e) => e.id == r.data.id)
        ..firstOrNull?.copyWith(status: r.data.status);

      state = state.copyWith(
          loading: false,
          parcelPickupResponse:
              state.parcelPickupResponse.copyWith(data: parcelList.unlock));
    });

    return success;
  }

  Future<bool> receivedParcel(String id) =>
      updateParcel(id: id, type: ParcelPickupType.received);

  Future<bool> cancelParcel(String id) =>
      updateParcel(id: id, type: ParcelPickupType.cancel);
}
