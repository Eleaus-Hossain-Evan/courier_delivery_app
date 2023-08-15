import 'package:courier_delivery_app/application/global.dart';
import 'package:courier_delivery_app/pickup_man/infrastructure/parcel_pickup_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/parcel/model/top_level_common_parcel_model.dart';

part 'parcel_pickup_provider.g.dart';

enum ParcelPickupType { assign }

@riverpod
class ParcelPickup extends _$ParcelPickup {
  final repo = ParcelPickupRepo();
  @override
  Future<List<TopLevelCommonParcelModel>> build({
    ParcelPickupType type = ParcelPickupType.assign,
    int page = 1,
    int limit = 10,
  }) async {
    final result = await repo.getPickupParcelList();

    return result.fold((l) {
      showErrorToast(l.error.message);
      return [];
    }, (r) => r.data);
  }

  // Add methods to mutate the state
}
