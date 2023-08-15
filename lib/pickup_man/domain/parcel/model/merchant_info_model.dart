import 'dart:convert';

import 'package:equatable/equatable.dart';

class MerchantInfoModel extends Equatable {
  final String address;
  final String shopAddress;
  final String name;
  final String phone;
  final String shopName;

  const MerchantInfoModel({
    required this.address,
    required this.shopAddress,
    required this.name,
    required this.phone,
    required this.shopName,
  });

  factory MerchantInfoModel.init() => const MerchantInfoModel(
      address: '', shopAddress: '', name: '', phone: '', shopName: '');

  MerchantInfoModel copyWith({
    String? address,
    String? shopAddress,
    String? name,
    String? phone,
    String? shopName,
  }) {
    return MerchantInfoModel(
      address: address ?? this.address,
      shopAddress: shopAddress ?? this.shopAddress,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      shopName: shopName ?? this.shopName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'shopAddress': shopAddress,
      'name': name,
      'phone': phone,
      'shopName': shopName,
    };
  }

  factory MerchantInfoModel.fromMap(Map<String, dynamic> map) {
    return MerchantInfoModel(
      address: map['address'] ?? '',
      shopAddress: map['shopAddress'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      shopName: map['shopName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MerchantInfoModel.fromJson(String source) =>
      MerchantInfoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MerchantInfo(address: $address, shopAddress: $shopAddress, name: $name, phone: $phone, shopName: $shopName)';
  }

  @override
  List<Object> get props {
    return [
      address,
      shopAddress,
      name,
      phone,
      shopName,
    ];
  }
}
