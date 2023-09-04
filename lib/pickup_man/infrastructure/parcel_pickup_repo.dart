import 'package:courier_delivery_app/pickup_man/domain/parcel/parcel_pickup_list_response.dart';
import 'package:courier_delivery_app/utils/utils.dart';
import 'package:flutter_easylogger/flutter_logger.dart';

import '../domain/parcel/model/top_level_pickup_parcel_model.dart';
import '../domain/parcel/update_parcel_pickup_response.dart';

class ParcelPickupRepo {
  final api = NetworkHandler.instance;

  Future<Either<CleanFailure, ParcelPickupListResponse>> getPickupParcelList({
    ParcelPickupStatus type = ParcelPickupStatus.all,
    int page = 1,
    int limit = 10,
    bool isComplete = false,
  }) async {
    final data = await api.post(
      body: {"status": type.name, "isComplete": isComplete},
      fromData: (json) => ParcelPickupListResponse.fromMap(json),
      endPoint: "${EndPointPickUp.PARCEL_PICKUPMAN}page=$page&limit=$limit",
      withToken: true,
    );

    // Logger.d(data);

    return data;
  }

  Future<Either<CleanFailure, UpdateParcelPickupResponse>> updatePickupParcel({
    ParcelPickupStatus status = ParcelPickupStatus.all,
    required String id,
    required String note,
  }) async {
    final data = await api.patch(
      body: {"status": status.name, "note": note},
      fromData: (json) => UpdateParcelPickupResponse.fromMap(json),
      endPoint: "${EndPointPickUp.UPDATE_PARCEL_PICKUPMAN}$id",
      withToken: true,
    );

    Logger.d(data);

    return data;
  }
}
