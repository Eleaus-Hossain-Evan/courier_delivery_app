import 'dart:convert';

import 'model/user_model.dart';

class AuthResponse {
  final UserModel data;
  final bool success;
  final String message;

  AuthResponse({
    required this.data,
    required this.success,
    required this.message,
  });

  AuthResponse copyWith({
    UserModel? data,
    bool? success,
    String? message,
  }) {
    return AuthResponse(
      data: data ?? this.data,
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.toMap(),
      'success': success,
      'message': message,
    };
  }

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      data: UserModel.fromMap(map['data']),
      success: map['success'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromJson(String source) =>
      AuthResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'LoginResponse(data: $data, success: $success, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthResponse &&
        other.data == data &&
        other.success == success &&
        other.message == message;
  }

  @override
  int get hashCode => data.hashCode ^ success.hashCode ^ message.hashCode;
}
