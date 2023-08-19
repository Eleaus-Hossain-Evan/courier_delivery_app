import 'package:courier_delivery_app/application/global.dart';
import 'package:courier_delivery_app/pickup_man/infrastructure/parcel_pickup_repo.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/parcel/model/top_level_pickup_parcel_model.dart';
import 'parcel_pickup_state.dart';

final parcelPickupProvider =
    StateNotifierProvider<ParcelPickupNotifier, ParcelPickupState>((ref) {
  return ParcelPickupNotifier(ref, ParcelPickupRepo());
}, name: "parcelPickupProvider");

class ParcelPickupNotifier extends StateNotifier<ParcelPickupState> {
  final Ref ref;
  final ParcelPickupRepo repo;

  ParcelPickupNotifier(this.ref, this.repo) : super(ParcelPickupState.init());

  void setState(ParcelPickupState state) => state = this.state;

  Future<bool> parcelPickupList({
    ParcelPickupType type = ParcelPickupType.all,
    int page = 1,
    int limit = 10,
    bool isComplete = false,
  }) async {
    var success = false;
    state = state.copyWith(loading: true);

    final result = await repo.getPickupParcelList(
        type: type, page: page, limit: limit, isComplete: false);

    result.fold((l) {
      showErrorToast(l.error.message);

      state = state.copyWith(loading: false);
    }, (r) {
      success = r.success;
      final finalList = [
        ...state.parcelPickupResponse.data,
        ...r.data.map((e) => e.copyWith(isComplete: isComplete))
      ]..removeDuplicates(by: (item) => item.id);

      // finalList.removeDuplicates(by: (item) => item.id);
      // Logger.i(r);
      state = state.copyWith(
          loading: false, parcelPickupResponse: r.copyWith(data: finalList));
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
    required int page,
    bool shouldRemove = false,
  }) async {
    var success = false;
    // state = state.copyWith(loading: true);

    // final index =
    //     state.parcelPickupResponse.data.lock.indexWhere((e) => e.id == id);
    // Logger.i(index);

    // final parcelList =
    //     state.parcelPickupResponse.data.lock[index].copyWith(status: type);
    // Logger.i('parcelList: $parcelList');
    // final parcelListNew =
    //     state.parcelPickupResponse.data.lock.replace(index, parcelList);
    // Logger.i('parcelListNew: $parcelListNew');

    // state = state.copyWith(
    //     loading: false,
    //     parcelPickupResponse:
    //         state.parcelPickupResponse.copyWith(data: parcelListNew.unlock));
    // Logger.i('state: $state');

    final result = await repo.updatePickupParcel(type: type, id: id);

    result.fold((l) {
      showErrorToast(l.error.message);

      state = state.copyWith(loading: false);
    }, (r) async {
      Logger.i(r);

      // final parcelList = state.parcelPickupResponse.data.lock
      //   ..firstWhere((e) => e.id == r.data.id).copyWith(status: r.data.status);

      final index =
          state.parcelPickupResponse.data.lock.indexWhere((e) => e.id == id);
      Logger.i(index);

      if (shouldRemove) {
        final parcelList = state.parcelPickupResponse.data.lock.removeAt(index);
        state = state.copyWith(
            loading: false,
            parcelPickupResponse:
                state.parcelPickupResponse.copyWith(data: parcelList.unlock));
      } else {
        final parcelList =
            state.parcelPickupResponse.data.lock[index].copyWith(status: type);
        Logger.i('parcelList: $parcelList');
        final parcelListNew =
            state.parcelPickupResponse.data.lock.replace(index, parcelList);
        Logger.i('parcelListNew: $parcelListNew');

        state = state.copyWith(
            loading: false,
            parcelPickupResponse: state.parcelPickupResponse
                .copyWith(data: parcelListNew.unlock));

        // state = state.copyWith(
        //     loading: false,
        //     parcelPickupResponse:
        //         state.parcelPickupResponse.copyWith(data: parcelListNew.unlock));
        // Logger.i('state: $state');
      }
    });
    return success;
  }

  Future<bool> receivedParcel(String id, int page,
          {bool shouldRemove = false}) =>
      updateParcel(
          id: id,
          type: ParcelPickupType.received,
          page: page,
          shouldRemove: shouldRemove);

  Future<bool> cancelParcel(String id, int page, {bool shouldRemove = false}) =>
      updateParcel(
          id: id,
          type: ParcelPickupType.cancel,
          page: page,
          shouldRemove: shouldRemove);
}
