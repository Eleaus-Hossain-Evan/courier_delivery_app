import 'package:courier_delivery_app/domain/dashboard/dashboard_reponse.dart';
import 'package:courier_delivery_app/utils/api_endpoints/api_rider_endpoint.dart';

import '../utils/utils.dart';

class DashboardRepo {
  final api = NetworkHandler.instance;

  Future<Either<CleanFailure, DashboardResponse>> getDashboard(
      {bool isPickup = false}) async {
    final data = await api.get(
      fromData: (json) => DashboardResponse.fromMap(json),
      endPoint: isPickup ? EndPointPickUp.DASHBOARD : EndPointRider.DASHBOARD,
      withToken: true,
    );

    return data;
  }
}
