import 'package:courier_delivery_app/domain/parcel/model/top_level_rider_parcel_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
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

  Future<bool> riderParcelUpdate({
    required String parcelId,
    required ParcelRiderType status,
    required ParcelRiderStatus parcelStatus,
    required int cashCollected,
    bool shouldRemove = false,
  }) async {
    bool success = false;

    final result = await repo.riderParcelUpdate(
      parcelId: parcelId,
      status: status,
      parcelStatus: parcelStatus,
      cashCollected: cashCollected,
    );

    result.fold((l) {
      showErrorToast(l.error.message);

      state = state.copyWith(loading: false);
    }, (r) async {
      Logger.i(r);

      // final parcelList = state.parcelPickupResponse.data.lock
      //   ..firstWhere((e) => e.id == r.data.id).copyWith(status: r.data.status);

      final index = state.parcelRiderResponse.data.lock
          .indexWhere((e) => e.id == parcelId);
      Logger.i(index);

      if (shouldRemove) {
        final parcelList = state.parcelRiderResponse.data.lock.removeAt(index);
        state = state.copyWith(
            loading: false,
            parcelRiderResponse:
                state.parcelRiderResponse.copyWith(data: parcelList.unlock));
      } else {
        final parcelList = state.parcelRiderResponse.data.lock[index]
            .copyWith(status: status, parcelStatus: parcelStatus);
        Logger.i('parcelList: $parcelList');
        final parcelListNew =
            state.parcelRiderResponse.data.lock.replace(index, parcelList);
        Logger.i('parcelListNew: $parcelListNew');

        state = state.copyWith(
            loading: false,
            parcelRiderResponse:
                state.parcelRiderResponse.copyWith(data: parcelListNew.unlock));

        // state = state.copyWith(
        //     loading: false,
        //     parcelPickupResponse:
        //         state.parcelPickupResponse.copyWith(data: parcelListNew.unlock));
        // Logger.i('state: $state');
      }
    });
    return success;
  }

  receivedParcel(String id, int value, {required bool shouldRemove}) {}

  cancelParcel(String id, int value, {required bool shouldRemove}) {}
}
