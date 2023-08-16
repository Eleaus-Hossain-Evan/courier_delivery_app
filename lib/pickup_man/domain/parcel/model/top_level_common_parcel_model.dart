import 'dart:convert';

import 'status_history_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/parcel/model/parcel_model.dart';

enum ParcelPickupType { all, assign, received, cancel }

class TopLevelCommonParcelModel extends Equatable {
  final String id;
  final ParcelPickupType status;
  final List<StatusHistoryModel> statusHistory;
  final String createdAt;
  final String updatedAt;
  final ParcelModel parcel;
  const TopLevelCommonParcelModel({
    required this.id,
    required this.status,
    required this.statusHistory,
    required this.createdAt,
    required this.updatedAt,
    required this.parcel,
  });

  TopLevelCommonParcelModel copyWith({
    String? id,
    ParcelPickupType? status,
    List<StatusHistoryModel>? statusHistory,
    String? createdAt,
    String? updatedAt,
    ParcelModel? parcel,
  }) {
    return TopLevelCommonParcelModel(
      id: id ?? this.id,
      status: status ?? this.status,
      statusHistory: statusHistory ?? this.statusHistory,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      parcel: parcel ?? this.parcel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'status': status.name,
      'statusHistory': statusHistory.map((x) => x.toMap()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'parcel': parcel.toMap(),
    };
  }

  factory TopLevelCommonParcelModel.fromMap(Map<String, dynamic> map) {
    return TopLevelCommonParcelModel(
      id: map['_id'] ?? '',
      status: ParcelPickupType.values.byName(map['status']),
      statusHistory: List<StatusHistoryModel>.from(
          map['statusHistory']?.map((x) => StatusHistoryModel.fromMap(x)) ??
              const []),
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      parcel: ParcelModel.fromMap(map['parcel']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TopLevelCommonParcelModel.fromJson(String source) =>
      TopLevelCommonParcelModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(_id: $id, status: $status, statusHistory: $statusHistory, createdAt: $createdAt, updatedAt: $updatedAt, parcel: $parcel)';
  }

  @override
  List<Object> get props {
    return [
      id,
      status,
      statusHistory,
      createdAt,
      updatedAt,
      parcel,
    ];
  }
}
