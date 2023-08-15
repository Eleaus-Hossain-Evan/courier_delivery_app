import 'dart:convert';

import 'package:equatable/equatable.dart';

class ParcelCategoryModelResponse extends Equatable {
  final List<ParcelCategoryModel> data;
  final String message;
  final bool success;
  const ParcelCategoryModelResponse({
    required this.data,
    required this.message,
    required this.success,
  });

  ParcelCategoryModelResponse copyWith({
    List<ParcelCategoryModel>? data,
    String? message,
    bool? success,
  }) {
    return ParcelCategoryModelResponse(
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

  factory ParcelCategoryModelResponse.fromMap(Map<String, dynamic> map) {
    return ParcelCategoryModelResponse(
      data: List<ParcelCategoryModel>.from(
          map['data']?.map((x) => ParcelCategoryModel.fromMap(x)) ?? const []),
      message: map['message'] ?? '',
      success: map['success'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParcelCategoryModelResponse.fromJson(String source) =>
      ParcelCategoryModelResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'ParcelCategoryModelResponse(data: $data, message: $message, success: $success)';

  @override
  List<Object> get props => [data, message, success];
}

class ParcelCategoryModel extends Equatable {
  final String id;
  final String name;
  final String createdAt;
  final String updatedAt;

  const ParcelCategoryModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  ParcelCategoryModel copyWith({
    String? id,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) {
    return ParcelCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ParcelCategoryModel.fromMap(Map<String, dynamic> map) {
    return ParcelCategoryModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ParcelCategoryModel.fromJson(String source) =>
      ParcelCategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(_id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      createdAt,
      updatedAt,
    ];
  }
}
