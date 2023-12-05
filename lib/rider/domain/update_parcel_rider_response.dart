import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:courier_delivery_app/domain/parcel/model/status_history_model.dart';

import '../../utils/utils.dart';

class UpdateParcelRiderResponse extends Equatable {
  final UpdateParcelRiderModel data;
  final String message;
  final bool success;
  const UpdateParcelRiderResponse({
    required this.data,
    required this.message,
    required this.success,
  });

  UpdateParcelRiderResponse copyWith({
    UpdateParcelRiderModel? data,
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
      data: UpdateParcelRiderModel.fromMap(map['data']),
      message: map['message'] ?? '',
      success: map['success'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateParcelRiderResponse.fromJson(String source) =>
      UpdateParcelRiderResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'UpdateParcelRiderResponse(data: $data, message: $message, success: $success)';

  @override
  List<Object> get props => [data, message, success];
}

class UpdateParcelRiderModel extends Equatable {
  final String id;
  final bool isComplete;
  final int cashCollected;
  final String note;
  final ParcelRiderStatus parcelStatus;
  final ParcelRiderType status;
  final String hubId;
  final String riderId;
  final String parcelId;
  final List<StatusHistoryModel> statusHistory;
  final String createdAt;
  final String updatedAt;

  const UpdateParcelRiderModel({
    required this.isComplete,
    required this.cashCollected,
    required this.note,
    required this.parcelStatus,
    required this.status,
    required this.id,
    required this.hubId,
    required this.riderId,
    required this.parcelId,
    required this.statusHistory,
    required this.createdAt,
    required this.updatedAt,
  });

  UpdateParcelRiderModel copyWith({
    bool? isComplete,
    int? cashCollected,
    String? note,
    ParcelRiderStatus? parcelStatus,
    ParcelRiderType? status,
    String? id,
    String? hubId,
    String? riderId,
    String? parcelId,
    List<StatusHistoryModel>? statusHistory,
    String? createdAt,
    String? updatedAt,
  }) {
    return UpdateParcelRiderModel(
      isComplete: isComplete ?? this.isComplete,
      cashCollected: cashCollected ?? this.cashCollected,
      note: note ?? this.note,
      parcelStatus: parcelStatus ?? this.parcelStatus,
      status: status ?? this.status,
      id: id ?? this.id,
      hubId: hubId ?? this.hubId,
      riderId: riderId ?? this.riderId,
      parcelId: parcelId ?? this.parcelId,
      statusHistory: statusHistory ?? this.statusHistory,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'isComplete': isComplete,
      'cashCollected': cashCollected,
      'note': note,
      'parcelStatus': parcelStatus,
      'status': status,
      'hubId': hubId,
      'riderId': riderId,
      'parcelId': parcelId,
      'statusHistory': statusHistory.map((x) => x.toMap()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UpdateParcelRiderModel.fromMap(Map<String, dynamic> map) {
    return UpdateParcelRiderModel(
      id: map['_id'] ?? '',
      isComplete: map['isComplete'] ?? false,
      cashCollected: map['cashCollected']?.toInt() ?? 0,
      note: map['note'] ?? '',
      parcelStatus: ParcelRiderStatus.values
          .firstWhere((e) => e.value == map['parcelStatus']),
      status: ParcelRiderType.values.byName(map['status']),
      hubId: map['hubId'] ?? '',
      riderId: map['riderId'] ?? '',
      parcelId: map['parcelId'] ?? '',
      statusHistory: List<StatusHistoryModel>.from(
          map['statusHistory']?.map((x) => StatusHistoryModel.fromMap(x)) ??
              const []),
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateParcelRiderModel.fromJson(String source) =>
      UpdateParcelRiderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UpdateParcelRiderModel(isComplete: $isComplete, cashCollected: $cashCollected, note: $note, parcelStatus: $parcelStatus, status: $status, id: $id, hubId: $hubId, riderId: $riderId, parcelId: $parcelId, statusHistory: $statusHistory, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      isComplete,
      cashCollected,
      note,
      parcelStatus,
      status,
      id,
      hubId,
      riderId,
      parcelId,
      statusHistory,
      createdAt,
      updatedAt,
    ];
  }
}
