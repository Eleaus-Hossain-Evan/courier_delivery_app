import 'dart:convert';

import 'package:courier_delivery_app/domain/meta_data_model.dart';
import 'package:courier_delivery_app/domain/parcel/model/top_level_rider_parcel_model.dart';
import 'package:equatable/equatable.dart';

class ParcelRiderListResponse extends Equatable {
  final MetaDataModel metaData;
  final List<TopLevelRiderParcelModel> data;
  final String message;
  final bool success;

  const ParcelRiderListResponse({
    required this.metaData,
    required this.data,
    required this.message,
    required this.success,
  });

  factory ParcelRiderListResponse.init() => ParcelRiderListResponse(
      metaData: MetaDataModel.init(),
      data: const [],
      message: '',
      success: false);

  ParcelRiderListResponse copyWith({
    MetaDataModel? metaData,
    List<TopLevelRiderParcelModel>? data,
    String? message,
    bool? success,
  }) {
    return ParcelRiderListResponse(
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

  factory ParcelRiderListResponse.fromMap(Map<String, dynamic> map) {
    return ParcelRiderListResponse(
      metaData: MetaDataModel.fromMap(map['metaData']),
      data: List<TopLevelRiderParcelModel>.from(
          map['data']?.map((x) => TopLevelRiderParcelModel.fromMap(x)) ??
              const []),
      message: map['message'] ?? '',
      success: map['success'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParcelRiderListResponse.fromJson(String source) =>
      ParcelRiderListResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ParcelListResponse(metaData: $metaData, data: $data, message: $message, success: $success)';
  }

  @override
  List<Object> get props => [metaData, data, message, success];
}
