import 'package:courier_delivery_app/pickup_man/domain/parcel/parcel_list_response.dart';
import 'package:courier_delivery_app/utils/utils.dart';

import '../application/parcel_pickup/parcel_pickup_provider.dart';

class ParcelPickupRepo {
  final api = NetworkHandler.instance;

  Future<Either<CleanFailure, ParcelListResponse>> getPickupParcelList({
    ParcelPickupType type = ParcelPickupType.assign,
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

    return data;
  }
}
