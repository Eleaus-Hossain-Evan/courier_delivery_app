import 'dart:convert';

import 'package:equatable/equatable.dart';

class WeightModelResponse extends Equatable {
  final List<WeightModel> data;
  final String message;
  final bool success;

  const WeightModelResponse({
    required this.data,
    required this.message,
    required this.success,
  });

  WeightModelResponse copyWith({
    List<WeightModel>? data,
    String? message,
    bool? success,
  }) {
    return WeightModelResponse(
      data: data ?? this.data,
      message: message ?? this.message,
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((x) => x.toMap()).toList(),
      'message': message,
      'success': success,
    };
  }

  factory WeightModelResponse.fromMap(Map<String, dynamic> map) {
    return WeightModelResponse(
      data: List<WeightModel>.from(
          map['data']?.map((x) => WeightModel.fromMap(x)) ?? const []),
      message: map['message'] ?? '',
      success: map['success'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeightModelResponse.fromJson(String source) =>
      WeightModelResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'WeghtModelResponse(data: $data, message: $message, success: $success)';

  @override
  List<Object> get props => [data, message, success];
}

class WeightModel extends Equatable {
  final String id;
  final String name;
  final int price;
  final String createdAt;
  final String updatedAt;
  const WeightModel({
    required this.id,
    required this.name,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  WeightModel copyWith({
    String? id,
    String? name,
    int? price,
    String? createdAt,
    String? updatedAt,
  }) {
    return WeightModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory WeightModel.fromMap(Map<String, dynamic> map) {
    return WeightModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toInt() ?? 0,
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WeightModel.fromJson(String source) =>
      WeightModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(_id: $id, name: $name, price: $price, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      price,
      createdAt,
      updatedAt,
    ];
  }
}
