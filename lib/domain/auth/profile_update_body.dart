import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProfileUpdateBody extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String address;

  const ProfileUpdateBody({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  ProfileUpdateBody copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
  }) {
    return ProfileUpdateBody(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }

  factory ProfileUpdateBody.fromMap(Map<String, dynamic> map) {
    return ProfileUpdateBody(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileUpdateBody.fromJson(String source) =>
      ProfileUpdateBody.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProfileUpdateBody(name: $name, email: $email, phone: $phone, address: $address)';
  }

  @override
  List<Object> get props => [name, email, phone, address];
}
