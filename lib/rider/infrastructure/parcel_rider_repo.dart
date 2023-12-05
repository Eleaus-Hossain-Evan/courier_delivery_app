import 'package:courier_delivery_app/utils/api_endpoints/api_rider_endpoint.dart';

import '../domain/parcel_pickup_list_response.dart';
import '../domain/update_parcel_rider_response.dart';
import '../../utils/utils.dart';

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

  Future<Either<CleanFailure, UpdateParcelRiderResponse>> riderParcelUpdate({
    required String parcelId,
    required ParcelRiderType status,
    required ParcelRiderStatus parcelStatus,
    required int cashCollected,
    required String note,
  }) async {
    final data = await api.patch(
      body: {
        "status": status.name,
        "parcelStatus": parcelStatus.value,
        "cashCollected": cashCollected,
        "note": note
      },
      fromData: (json) => UpdateParcelRiderResponse.fromMap(json),
      endPoint: "${EndPointRider.UPDATE_PARCEL}$parcelId",
      withToken: true,
    );

    // Logger.d(data);

    return data;
  }
}
