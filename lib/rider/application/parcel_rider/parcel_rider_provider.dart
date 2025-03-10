import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:courier_delivery_app/rider/application/parcel_rider/parcel_rider_state.dart';
import 'package:courier_delivery_app/rider/infrastructure/parcel_rider_repo.dart';

import '../../../utils/utils.dart';
import '../../../application/global.dart';

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
      final finalList = [...state.parcelRiderResponse.data, ...r.data]
        ..removeDuplicates(by: (item) => item.id);

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
    required String note,
    bool shouldRemove = false,
  }) async {
    bool success = false;

    final result = await repo.riderParcelUpdate(
      parcelId: parcelId,
      status: status,
      parcelStatus: parcelStatus,
      cashCollected: cashCollected,
      note: note,
    );

    result.fold((l) {
      showErrorToast(l.error.message);

      state = state.copyWith(loading: false);
    }, (r) async {
      // Logger.i(r);

      // final parcelList = state.parcelPickupResponse.data.lock
      //   ..firstWhere((e) => e.id == r.data.id).copyWith(status: r.data.status);

      final index = state.parcelRiderResponse.data.lock.indexWhere(
          (e) => e.id == r.data.id && e.parcel.id == r.data.parcelId);
      Logger.i(index);

      if (shouldRemove) {
        final parcelList = state.parcelRiderResponse.data.lock.removeAt(index);
        state = state.copyWith(
            loading: false,
            parcelRiderResponse:
                state.parcelRiderResponse.copyWith(data: parcelList.unlock));
      } else {
        final parcelList = state.parcelRiderResponse.data.lock.replace(
          index,
          state.parcelRiderResponse.data[index].copyWith(
            status: r.data.status,
            parcelStatus: r.data.parcelStatus,
            note: r.data.note,
            isComplete: r.data.isComplete,
          ),
        );
        state = state.copyWith(
          parcelRiderResponse:
              state.parcelRiderResponse.copyWith(data: parcelList.unlock),
        );
        success = r.success;
      }
    });
    return success;
  }
}
