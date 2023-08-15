import 'dart:io';

import 'package:courier_delivery_app/utils/api_endpoints/api_rider_endpoint.dart';

import '../domain/auth/login_body.dart';
import '../domain/auth/auth_response.dart';
import '../domain/auth/model/user_model.dart';
import '../domain/auth/password_update_body.dart';
import '../domain/auth/signup_body.dart';
import '../utils/utils.dart';

class AuthRepo {
  final api = NetworkHandler.instance;

  Future<Either<CleanFailure, AuthResponse>> loginPickUp(LoginBody body) async {
    final data = await api.post(
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: EndPointPickUp.LOGIN,
      body: body.toMap(),
      withToken: false,
    );

    return data;
  }

  Future<Either<CleanFailure, AuthResponse>> loginRider(LoginBody body) async {
    final data = await api.post(
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: EndPointRider.LOGIN,
      body: body.toMap(),
      withToken: false,
    );

    return data;
  }

  Future<Either<CleanFailure, AuthResponse>> signUp(SignUpBody body) async {
    final data = await api.post(
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: EndPointRider.SIGN_UP,
      body: body.toMap(),
      withToken: false,
    );

    return data;
  }

  Future<Either<CleanFailure, AuthResponse>> profileView() async {
    final data = await api.get(
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: EndPointPickUp.PROFILE_VIEW,
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, AuthResponse>> profileUpdate(
      UserModel body) async {
    final data = await api.patch(
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: EndPointPickUp.PROFILE_UPDATE,
      body: body.toMap(),
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, AuthResponse>> imageUpload(File image) async {
    // var request = MultipartRequest(
    //     'PATCH', Uri.parse(APIRoute.BASE_URL + APIRoute.IMAGE_UPLOAD));

    // request.files.add(
    //   MultipartFile.fromBytes(
    //     'image',
    //     File(image.path).readAsBytesSync(),
    //     filename: image.path,
    //   ),
    // );
    // final res = await request.send();
    // final response = await Response.fromStream(res);
    // Logger.v(res);
    // Logger.v(response.body);
    // final Map<String, dynamic> data = jsonDecode(response.body);
    // Logger.v(data['data']['Location']);
    // return data['data']['Location'];
    final bytes = image.readAsBytesSync();
    final imageString = Uri.dataFromBytes(
      bytes,
      mimeType: 'image/png',
    ).toString();

    final data = await api.patch(
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: EndPointPickUp.IMAGE_UPLOAD,
      body: {"image": imageString},
      withToken: true,
    );

    return data;
  }

  Future<Either<CleanFailure, AuthResponse>> passwordUpdate(
      PasswordUpdateBody body) async {
    final data = await api.patch(
      body: body.toMap(),
      fromData: (json) => AuthResponse.fromMap(json),
      endPoint: EndPointPickUp.PASSWORD_UPDATE,
      withToken: true,
    );

    return data;
  }
}
