import 'package:courier_delivery_app/utils/api_endpoints/api_rider_endpoint.dart';

import '../domain/parcel/model/top_level_rider_parcel_model.dart';
import '../domain/parcel/parcel_pickup_list_response.dart';
import '../utils/utils.dart';

class ParcelRiderRepo {
  final api = NetworkHandler.instance;

  Future<Either<CleanFailure, ParcelRiderListResponse>> getRiderParcelList(
      {required ParcelRiderType type,
      required int page,
      required int limit,
      required bool isComplete}) async {
    final data = await api.post(
      body: {"status": type.name, "isComplete": isComplete},
      fromData: (json) => ParcelRiderListResponse.fromMap(json),
      endPoint: "${EndPointRider.PARCEL_PICKUPMAN}page=$page&limit=$limit",
      withToken: true,
    );

    // Logger.d(data);

    return data;
  }
}
