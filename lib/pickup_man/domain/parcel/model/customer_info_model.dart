import 'dart:convert';

import 'package:equatable/equatable.dart';

class CustomerInfoModel extends Equatable {
  final String name;
  final String phone;
  final String address;
  final String districtId;
  final String areaId;

  const CustomerInfoModel({
    required this.name,
    required this.phone,
    required this.address,
    required this.districtId,
    required this.areaId,
  });

  factory CustomerInfoModel.init() => const CustomerInfoModel(
      name: '', phone: '', address: '', districtId: '', areaId: '');

  CustomerInfoModel copyWith({
    String? name,
    String? phone,
    String? address,
    String? districtId,
    String? areaId,
  }) {
    return CustomerInfoModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      districtId: districtId ?? this.districtId,
      areaId: areaId ?? this.areaId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'districtId': districtId,
      'areaId': areaId,
    };
  }

  factory CustomerInfoModel.fromMap(Map<String, dynamic> map) {
    return CustomerInfoModel(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      districtId: map['districtId'] ?? '',
      areaId: map['areaId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerInfoModel.fromJson(String source) =>
      CustomerInfoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerInfo(name: $name, phone: $phone, address: $address, districtId: $districtId, areaId: $areaId)';
  }

  @override
  List<Object> get props {
    return [
      name,
      phone,
      address,
      districtId,
      areaId,
    ];
  }
}
