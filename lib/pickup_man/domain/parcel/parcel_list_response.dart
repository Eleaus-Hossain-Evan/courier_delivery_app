import 'dart:convert';

import 'package:courier_delivery_app/domain/meta_data_model.dart';
import 'package:equatable/equatable.dart';

import 'model/top_level_common_parcel_model.dart';

class ParcelListResponse extends Equatable {
  final MetaDataModel metaData;
  final List<TopLevelCommonParcelModel> data;
  final String message;
  final bool success;
  const ParcelListResponse({
    required this.metaData,
    required this.data,
    required this.message,
    required this.success,
  });

  ParcelListResponse copyWith({
    MetaDataModel? metaData,
    List<TopLevelCommonParcelModel>? data,
    String? message,
    bool? success,
  }) {
    return ParcelListResponse(
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

  factory ParcelListResponse.fromMap(Map<String, dynamic> map) {
    return ParcelListResponse(
      metaData: MetaDataModel.fromMap(map['metaData']),
      data: List<TopLevelCommonParcelModel>.from(
          map['data']?.map((x) => TopLevelCommonParcelModel.fromMap(x)) ??
              const []),
      message: map['message'] ?? '',
      success: map['success'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParcelListResponse.fromJson(String source) =>
      ParcelListResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ParcelListResponse(metaData: $metaData, data: $data, message: $message, success: $success)';
  }

  @override
  List<Object> get props => [metaData, data, message, success];
}
