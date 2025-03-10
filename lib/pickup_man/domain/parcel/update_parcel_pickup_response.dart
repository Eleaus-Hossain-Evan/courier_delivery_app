import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';

class UpdateParcelPickupResponse extends Equatable {
  final UpdateParcelModel data;
  final String message;
  final bool success;
  const UpdateParcelPickupResponse({
    required this.data,
    required this.message,
    required this.success,
  });

  UpdateParcelPickupResponse copyWith({
    UpdateParcelModel? data,
    String? message,
    bool? success,
  }) {
    return UpdateParcelPickupResponse(
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

  factory UpdateParcelPickupResponse.fromMap(Map<String, dynamic> map) {
    return UpdateParcelPickupResponse(
      data: UpdateParcelModel.fromMap(map['data']),
      message: map['message'] ?? '',
      success: map['success'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateParcelPickupResponse.fromJson(String source) =>
      UpdateParcelPickupResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'UpdateParcelResponse(data: $data, message: $message, success: $success)';

  @override
  List<Object> get props => [data, message, success];
}

class UpdateParcelModel extends Equatable {
  final bool isComplete;
  final ParcelPickupStatus status;
  final String id;
  final String hubId;
  final String pickupmanId;
  final String parcelId;
  final String createdAt;
  final String updatedAt;

  const UpdateParcelModel({
    required this.isComplete,
    required this.status,
    required this.id,
    required this.hubId,
    required this.pickupmanId,
    required this.parcelId,
    required this.createdAt,
    required this.updatedAt,
  });

  UpdateParcelModel copyWith({
    bool? isComplete,
    ParcelPickupStatus? status,
    String? id,
    String? hubId,
    String? pickupmanId,
    String? parcelId,
    String? createdAt,
    String? updatedAt,
  }) {
    return UpdateParcelModel(
      isComplete: isComplete ?? this.isComplete,
      status: status ?? this.status,
      id: id ?? this.id,
      hubId: hubId ?? this.hubId,
      pickupmanId: pickupmanId ?? this.pickupmanId,
      parcelId: parcelId ?? this.parcelId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isComplete': isComplete,
      'status': status.name,
      '_id': id,
      'hubId': hubId,
      'pickupmanId': pickupmanId,
      'parcelId': parcelId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UpdateParcelModel.fromMap(Map<String, dynamic> map) {
    return UpdateParcelModel(
      isComplete: map['isComplete'] ?? false,
      status: ParcelPickupStatus.values.byName(map['status']),
      id: map['_id'] ?? '',
      hubId: map['hubId'] ?? '',
      pickupmanId: map['pickupmanId'] ?? '',
      parcelId: map['parcelId'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateParcelModel.fromJson(String source) =>
      UpdateParcelModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UpdateParcelModel(isComplete: $isComplete, status: $status, _id: $id, hubId: $hubId, pickupmanId: $pickupmanId, parcelId: $parcelId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      isComplete,
      status,
      id,
      hubId,
      pickupmanId,
      parcelId,
      createdAt,
      updatedAt,
    ];
  }
}
