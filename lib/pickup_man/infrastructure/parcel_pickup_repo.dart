import 'package:courier_delivery_app/pickup_man/domain/parcel/parcel_list_response.dart';
import 'package:courier_delivery_app/utils/utils.dart';
import 'package:flutter_easylogger/flutter_logger.dart';

import '../domain/parcel/model/top_level_common_parcel_model.dart';
import '../domain/parcel/update_parcel_response.dart';

class ParcelPickupRepo {
  final api = NetworkHandler.instance;

  Future<Either<CleanFailure, ParcelListResponse>> getPickupParcelList({
    ParcelPickupType type = ParcelPickupType.all,
    int page = 1,
    int limit = 10,
    bool isComplete = false,
  }) async {
    final data = await api.post(
      body: {"status": type.name, "isComplete": isComplete},
      fromData: (json) => ParcelListResponse.fromMap(json),
      endPoint: "${EndPointPickUp.PARCEL_PICKUPMAN}page=$page&limit=$limit",
      withToken: true,
    );

    Logger.d(data);

    return data;
  }

  Future<Either<CleanFailure, UpdateParcelResponse>> updatePickupParcel({
    ParcelPickupType type = ParcelPickupType.all,
    required String id,
  }) async {
    final data = await api.post(
      body: {"status": type.name},
      fromData: (json) => UpdateParcelResponse.fromMap(json),
      endPoint: "${EndPointPickUp.UPDATE_PARCEL_PICKUPMAN}$id",
      withToken: true,
    );

    Logger.d(data);

    return data;
  }
}
