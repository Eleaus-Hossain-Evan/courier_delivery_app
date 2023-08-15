import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../meta_data_model.dart';
import 'model/parcel_model.dart';

class FetchAllParcelResponse extends Equatable {
  final MetaDataModel metaData;
  final List<ParcelModel> data;
  final String message;
  final bool success;

  const FetchAllParcelResponse({
    required this.metaData,
    required this.data,
    required this.message,
    required this.success,
  });

  FetchAllParcelResponse copyWith({
    MetaDataModel? metaData,
    List<ParcelModel>? data,
    String? message,
    bool? success,
  }) {
    return FetchAllParcelResponse(
      metaData: metaData ?? this.metaData,
      data: data ?? this.data,
      message: message ?? this.message,
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'metaData': metaData.toMap(),
      'data': data.map((x) => x.toMap()).toList(),
      'message': message,
      'success': success,
    };
  }

  factory FetchAllParcelResponse.fromMap(Map<String, dynamic> map) {
    return FetchAllParcelResponse(
      metaData: MetaDataModel.fromMap(map['metaData']),
      data: List<ParcelModel>.from(
          map['data']?.map((x) => ParcelModel.fromMap(x)) ?? const []),
      message: map['message'] ?? '',
      success: map['success'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchAllParcelResponse.fromJson(String source) =>
      FetchAllParcelResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FetchAllParcelResponse(metaData: $metaData, data: $data, message: $message, success: $success)';
  }

  @override
  List<Object> get props => [metaData, data, message, success];
}
