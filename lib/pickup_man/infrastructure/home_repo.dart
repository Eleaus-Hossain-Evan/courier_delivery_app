import 'package:flutter_easylogger/flutter_logger.dart';

import '../domain/home/home_response.dart';
import '../../utils/utils.dart';

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
