import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:courier_delivery_app/domain/parcel/model/top_level_rider_parcel_model.dart';
import 'package:courier_delivery_app/pickup_man/domain/parcel/model/status_history_model.dart';

class UpdateParcelRiderResponse extends Equatable {
  final UpdateRideParcelModel data;
  final String message;
  final bool success;
  const UpdateParcelRiderResponse({
    required this.data,
    required this.message,
    required this.success,
  });

  UpdateParcelRiderResponse copyWith({
    UpdateRideParcelModel? data,
    String? message,
    bool? success,
  }) {
    return UpdateParcelRiderResponse(
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

  factory UpdateParcelRiderResponse.fromMap(Map<String, dynamic> map) {
    return UpdateParcelRiderResponse(
      data: UpdateRideParcelModel.fromMap(map['data']),
      message: map['message'] ?? '',
      success: map['success'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateParcelRiderResponse.fromJson(String source) =>
      UpdateParcelRiderResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'UpdateParcelResponse(data: $data, message: $message, success: $success)';

  @override
  List<Object> get props => [data, message, success];
}

class UpdateRideParcelModel extends Equatable {
  final bool isComplete;
  final int cashCollected;
  final ParcelRiderType parcelStatus;
  final ParcelRiderType status;
  final String id;
  final String hubId;
  final String pickupmanId;
  final String parcelId;
  final List<StatusHistoryModel> statusHistory;
  final String createdAt;
  final String updatedAt;

  const UpdateRideParcelModel({
    required this.isComplete,
    required this.cashCollected,
    required this.parcelStatus,
    required this.status,
    required this.id,
    required this.hubId,
    required this.pickupmanId,
    required this.parcelId,
    required this.statusHistory,
    required this.createdAt,
    required this.updatedAt,
  });

  UpdateRideParcelModel copyWith({
    bool? isComplete,
    int? cashCollected,
    ParcelRiderType? parcelStatus,
    ParcelRiderType? status,
    String? id,
    String? hubId,
    String? pickupmanId,
    String? parcelId,
    List<StatusHistoryModel>? statusHistory,
    String? createdAt,
    String? updatedAt,
  }) {
    return UpdateRideParcelModel(
      isComplete: isComplete ?? this.isComplete,
      cashCollected: cashCollected ?? this.cashCollected,
      parcelStatus: parcelStatus ?? this.parcelStatus,
      status: status ?? this.status,
      id: id ?? this.id,
      hubId: hubId ?? this.hubId,
      pickupmanId: pickupmanId ?? this.pickupmanId,
      parcelId: parcelId ?? this.parcelId,
      statusHistory: statusHistory ?? this.statusHistory,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isComplete': isComplete,
      'cashCollected': cashCollected,
      'parcelStatus': parcelStatus.name,
      'status': status.name,
      '_id': id,
      'hubId': hubId,
      'pickupmanId': pickupmanId,
      'parcelId': parcelId,
      'statusHistory': statusHistory.map((x) => x.toMap()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UpdateRideParcelModel.fromMap(Map<String, dynamic> map) {
    return UpdateRideParcelModel(
      isComplete: map['isComplete'] ?? false,
      cashCollected: map['cashCollected']?.toInt() ?? 0,
      parcelStatus: ParcelRiderType.values.byName(map['parcelStatus']),
      status: ParcelRiderType.values.byName(map['status']),
      id: map['_id'] ?? '',
      hubId: map['hubId'] ?? '',
      pickupmanId: map['pickupmanId'] ?? '',
      parcelId: map['parcelId'] ?? '',
      statusHistory: List<StatusHistoryModel>.from(
          map['statusHistory']?.map((x) => StatusHistoryModel.fromMap(x)) ??
              const []),
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateRideParcelModel.fromJson(String source) =>
      UpdateRideParcelModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UpdateRideParcelModel(isComplete: $isComplete, cashCollected: $cashCollected, parcelStatus: $parcelStatus, status: $status, _id: $id, hubId: $hubId, pickupmanId: $pickupmanId, parcelId: $parcelId, statusHistory: $statusHistory, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      isComplete,
      cashCollected,
      parcelStatus,
      status,
      id,
      hubId,
      pickupmanId,
      parcelId,
      statusHistory,
      createdAt,
      updatedAt,
    ];
  }
}
