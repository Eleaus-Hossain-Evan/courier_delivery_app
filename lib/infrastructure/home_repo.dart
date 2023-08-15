import 'package:flutter_easylogger/flutter_logger.dart';

import '../../utils/network_util/network_handler.dart';

import '../domain/home/home_response.dart';
import '../utils/api_endpoints/api_pickup_endpoint.dart';

class HomeRepo {
  final api = NetworkHandler.instance;

  Future<Either<CleanFailure, HomeResponse>> getHomeDate() async {
    final data = await api.get(
      fromData: (json) => HomeResponse.fromMap(json),
      endPoint: EndPointPickUp.HOME,
      withToken: false,
    );

    Logger.v("data: $data");

    return data;
  }
}
