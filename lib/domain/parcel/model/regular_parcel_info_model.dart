import 'dart:convert';

import 'package:equatable/equatable.dart';

class RegularParcelInfoModel extends Equatable {
  final String invoiceId;
  final String weight;
  final int productPrice;
  final String materialType;
  final String category;
  final String details;

  const RegularParcelInfoModel({
    required this.invoiceId,
    required this.weight,
    required this.productPrice,
    required this.materialType,
    required this.category,
    required this.details,
  });

  factory RegularParcelInfoModel.init() => const RegularParcelInfoModel(
      invoiceId: '',
      weight: '',
      productPrice: 0,
      materialType: '',
      category: '',
      details: '');

  RegularParcelInfoModel copyWith({
    String? invoiceId,
    String? weight,
    int? productPrice,
    String? materialType,
    String? category,
    String? details,
  }) {
    return RegularParcelInfoModel(
      invoiceId: invoiceId ?? this.invoiceId,
      weight: weight ?? this.weight,
      productPrice: productPrice ?? this.productPrice,
      materialType: materialType ?? this.materialType,
      category: category ?? this.category,
      details: details ?? this.details,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'invoiceId': invoiceId,
      'weight': weight,
      'productPrice': productPrice,
      'materialType': materialType,
      'category': category,
      'details': details,
    };
  }

  factory RegularParcelInfoModel.fromMap(Map<String, dynamic> map) {
    return RegularParcelInfoModel(
      invoiceId: map['invoiceId'] ?? '',
      weight: map['weight'] ?? '',
      productPrice: map['productPrice']?.toInt() ?? 0,
      materialType: map['materialType'] ?? '',
      category: map['category'] ?? '',
      details: map['details'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegularParcelInfoModel.fromJson(String source) =>
      RegularParcelInfoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RegularParcelInfo(invoiceId: $invoiceId, weight: $weight, productPrice: $productPrice, materialType: $materialType, category: $category, details: $details)';
  }

  @override
  List<Object> get props {
    return [
      invoiceId,
      weight,
      productPrice,
      materialType,
      category,
      details,
    ];
  }
}
