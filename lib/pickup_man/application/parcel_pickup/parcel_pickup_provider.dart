import 'package:courier_delivery_app/application/global.dart';
import 'package:courier_delivery_app/pickup_man/infrastructure/parcel_pickup_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/parcel/model/top_level_common_parcel_model.dart';

part 'parcel_pickup_provider.g.dart';

enum ParcelPickupType { assign }

@riverpod
Future<List<TopLevelCommonParcelModel>> parcelPickup(
  ParcelPickupRef ref, {
  ParcelPickupType type = ParcelPickupType.assign,
  int page = 1,
  int limit = 10,
}) async {
  final result = await ParcelPickupRepo()
      .getPickupParcelList(type: type, page: page, limit: limit);
  var preList = <TopLevelCommonParcelModel>[];

  ref.listenSelf((previous, next) {
    preList = next.value ?? [];
  });

  // preList = ref.state.value ?? [];

  return result.fold((l) {
    showErrorToast(l.error.message);
    return preList;
  }, (r) => [...preList, ...r.data]);
}
