import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../../domain/parcel/model/parcel_model.dart';
import 'status_history_model.dart';

enum ParcelRiderType { all, assign, complete, reject }

enum ParcelRiderStatus { none, dropoff, partial, returns }

extension ParcelRiderStatusExt on ParcelRiderStatus {
  String get value {
    switch (this) {
      case ParcelRiderStatus.none:
        return "";
      case ParcelRiderStatus.dropoff:
        return "dropoff";
      case ParcelRiderStatus.partial:
        return "partial";
      case ParcelRiderStatus.returns:
        return "return";
    }
  }
}

class TopLevelRiderParcelModel extends Equatable {
  final String id;
  final bool isComplete;
  final int cashCollected;
  final ParcelRiderStatus parcelStatus;
  final ParcelRiderType status;
  final String createdAt;
  final String updatedAt;
  final ParcelModel parcel;
  const TopLevelRiderParcelModel({
    required this.id,
    required this.isComplete,
    required this.cashCollected,
    required this.parcelStatus,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.parcel,
  });

  TopLevelRiderParcelModel copyWith({
    String? id,
    bool? isComplete,
    int? cashCollected,
    ParcelRiderStatus? parcelStatus,
    ParcelRiderType? status,
    List<StatusHistoryModel>? statusHistory,
    String? createdAt,
    String? updatedAt,
    ParcelModel? parcel,
  }) {
    return TopLevelRiderParcelModel(
      id: id ?? this.id,
      isComplete: isComplete ?? this.isComplete,
      cashCollected: cashCollected ?? this.cashCollected,
      parcelStatus: parcelStatus ?? this.parcelStatus,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      parcel: parcel ?? this.parcel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'isComplete': isComplete,
      'cashCollected': cashCollected,
      'parcelStatus': parcelStatus.value,
      'status': status.name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'parcel': parcel.toMap(),
    };
  }

  factory TopLevelRiderParcelModel.fromMap(Map<String, dynamic> map) {
    return TopLevelRiderParcelModel(
      id: map['_id'] ?? '',
      isComplete: map['isComplete'] ?? false,
      cashCollected: map['cashCollected']?.toInt() ?? 0,
      parcelStatus: ParcelRiderStatus.values
          .firstWhere((e) => e.value == map['parcelStatus']),
      status: ParcelRiderType.values.byName(map['status']),
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      parcel: ParcelModel.fromMap(map['parcel']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TopLevelRiderParcelModel.fromJson(String source) =>
      TopLevelRiderParcelModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TopLevelRiderParcelModel(_id: $id, isComplete: $isComplete, cashCollected: $cashCollected, parcelStatus: $parcelStatus, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, parcel: $parcel)';
  }

  @override
  List<Object> get props {
    return [
      id,
      isComplete,
      cashCollected,
      parcelStatus,
      status,
      createdAt,
      updatedAt,
      parcel,
    ];
  }
}
