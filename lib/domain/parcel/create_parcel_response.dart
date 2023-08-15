import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'model/parcel_model.dart';

class CreateParcelResponse extends Equatable {
  final ParcelModel data;
  final String message;
  final bool success;

  const CreateParcelResponse({
    required this.data,
    required this.message,
    required this.success,
  });

  CreateParcelResponse copyWith({
    ParcelModel? data,
    String? message,
    bool? success,
  }) {
    return CreateParcelResponse(
      data: data ?? this.data,
      message: message ?? this.message,
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.toMap(),
      'message': message,
      'success': success,
    };
  }

  factory CreateParcelResponse.fromMap(Map<String, dynamic> map) {
    return CreateParcelResponse(
      data: ParcelModel.fromMap(map['data']),
      message: map['message'] ?? '',
      success: map['success'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateParcelResponse.fromJson(String source) =>
      CreateParcelResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'CreateParcelResponse(data: $data, message: $message, success: $success)';

  @override
  List<Object> get props => [data, message, success];
}
