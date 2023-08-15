import 'package:courier_delivery_app/pickup_man/domain/parcel/parcel_list_response.dart';
import 'package:courier_delivery_app/utils/utils.dart';

class ParcelPickupRepo {
  final api = NetworkHandler.instance;

  Future<Either<CleanFailure, ParcelListResponse>> getPickupParcelList() async {
    final data = await api.get(
      fromData: (json) => ParcelListResponse.fromMap(json),
      endPoint: EndPointPickUp.HOME,
      withToken: false,
    );

    return data;
  }
}
