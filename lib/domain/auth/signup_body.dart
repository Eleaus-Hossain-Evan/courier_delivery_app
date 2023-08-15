import 'dart:convert';

class SignUpBody {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String address;

  SignUpBody({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
  });

  SignUpBody copyWith({
    String? name,
    String? email,
    String? password,
    String? phone,
    String? address,
  }) {
    return SignUpBody(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
    };
  }

  factory SignUpBody.fromMap(Map<String, dynamic> map) {
    return SignUpBody(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpBody.fromJson(String source) =>
      SignUpBody.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SignUpBody(name: $name, email: $email, password: $password, phone: $phone, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignUpBody &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.phone == phone &&
        other.address == address;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        phone.hashCode ^
        address.hashCode;
  }
}
