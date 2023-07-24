import '../domain/notification/notification_model.dart';
import '../utils/utils.dart';

class NotificationRepo {
  final api = NetworkHandler.instance;
  Future<Either<CleanFailure, List<NotificationModel>>>
      getNotification() async {
    return right([]);
  }
}
