import 'dart:convert';

import 'package:equatable/equatable.dart';

class PasswordUpdateBody extends Equatable {
  final String oldPassword;
  final String password;
  const PasswordUpdateBody({
    required this.oldPassword,
    required this.password,
  });

  PasswordUpdateBody copyWith({
    String? oldPassword,
    String? password,
  }) {
    return PasswordUpdateBody(
      oldPassword: oldPassword ?? this.oldPassword,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'oldPassword': oldPassword,
      'password': password,
    };
  }

  factory PasswordUpdateBody.fromMap(Map<String, dynamic> map) {
    return PasswordUpdateBody(
      oldPassword: map['oldPassword'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PasswordUpdateBody.fromJson(String source) =>
      PasswordUpdateBody.fromMap(json.decode(source));

  @override
  String toString() =>
      'PasswordUpdateBody(oldPassword: $oldPassword, password: $password)';

  @override
  List<Object> get props => [oldPassword, password];
}
