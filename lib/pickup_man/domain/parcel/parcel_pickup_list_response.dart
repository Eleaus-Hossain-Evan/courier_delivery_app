import 'dart:convert';

import 'package:courier_delivery_app/domain/meta_data_model.dart';
import 'package:equatable/equatable.dart';

import 'model/top_level_pickup_parcel_model.dart';

class ParcelPickupListResponse extends Equatable {
  final MetaDataModel metaData;
  final List<TopLevelPickupParcelModel> data;
  final String message;
  final bool success;

  const ParcelPickupListResponse({
    required this.metaData,
    required this.data,
    required this.message,
    required this.success,
  });

  factory ParcelPickupListResponse.init() => ParcelPickupListResponse(
      metaData: MetaDataModel.init(),
      data: const [],
      message: '',
      success: false);

  ParcelPickupListResponse copyWith({
    MetaDataModel? metaData,
    List<TopLevelPickupParcelModel>? data,
    String? message,
    bool? success,
  }) {
    return ParcelPickupListResponse(
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

  factory ParcelPickupListResponse.fromMap(Map<String, dynamic> map) {
    return ParcelPickupListResponse(
      metaData: MetaDataModel.fromMap(map['metaData']),
      data: List<TopLevelPickupParcelModel>.from(
          map['data']?.map((x) => TopLevelPickupParcelModel.fromMap(x)) ??
              const []),
      message: map['message'] ?? '',
      success: map['success'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParcelPickupListResponse.fromJson(String source) =>
      ParcelPickupListResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ParcelListResponse(metaData: $metaData, data: $data, message: $message, success: $success)';
  }

  @override
  List<Object> get props => [metaData, data, message, success];
}
