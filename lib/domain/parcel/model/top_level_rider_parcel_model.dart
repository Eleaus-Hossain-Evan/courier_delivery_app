import 'dart:convert';

import 'status_history_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/parcel/model/parcel_model.dart';

enum ParcelRiderType { all, assign, received, dropoff, cancel }

class TopLevelRiderParcelModel extends Equatable {
  final String id;
  final ParcelRiderType status;
  final List<StatusHistoryModel> statusHistory;
  final String createdAt;
  final String updatedAt;
  final bool isComplete;
  final ParcelModel parcel;
  const TopLevelRiderParcelModel({
    required this.id,
    required this.status,
    required this.statusHistory,
    required this.createdAt,
    required this.updatedAt,
    required this.isComplete,
    required this.parcel,
  });

  TopLevelRiderParcelModel copyWith({
    String? id,
    ParcelRiderType? status,
    List<StatusHistoryModel>? statusHistory,
    String? createdAt,
    String? updatedAt,
    bool? isComplete,
    ParcelModel? parcel,
  }) {
    return TopLevelRiderParcelModel(
      id: id ?? this.id,
      status: status ?? this.status,
      statusHistory: statusHistory ?? this.statusHistory,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isComplete: isComplete ?? this.isComplete,
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
      "isComplete": isComplete,
      'parcel': parcel.toMap(),
    };
  }

  factory TopLevelRiderParcelModel.fromMap(Map<String, dynamic> map) {
    return TopLevelRiderParcelModel(
      id: map['_id'] ?? '',
      status: ParcelRiderType.values.byName(map['status']),
      statusHistory: List<StatusHistoryModel>.from(
          map['statusHistory']?.map((x) => StatusHistoryModel.fromMap(x)) ??
              const []),
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      isComplete: map["isComplete"] ?? false,
      parcel: ParcelModel.fromMap(map['parcel']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TopLevelRiderParcelModel.fromJson(String source) =>
      TopLevelRiderParcelModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(_id: $id, status: $status, statusHistory: $statusHistory, createdAt: $createdAt, updatedAt: $updatedAt, isComplete $isComplete, parcel: $parcel)';
  }

  @override
  List<Object> get props {
    return [
      id,
      status,
      statusHistory,
      createdAt,
      updatedAt,
      isComplete,
      parcel,
    ];
  }
}
