import '../domain/profile/review_body.dart';
import '../domain/simple_response.dart';
import '../utils/utils.dart';

class ProfileRepo {
  final api = NetworkHandler.instance;

  Future<Either<CleanFailure, SimpleResponse>> submitReviewRating(
      ReviewBody body) async {
    final data = await api.post(
      body: body.toMap(),
      fromData: (json) => SimpleResponse.fromMap(json),
      endPoint: EndPointPickUp.SUBMIT_REVIEW,
      withToken: true,
    );

    return data;
  }
}
