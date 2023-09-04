import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../../domain/parcel/model/parcel_model.dart';
import '../../../../utils/utils.dart';

class TopLevelPickupParcelModel extends Equatable {
  final String id;
  final ParcelPickupStatus status;
  final String note;
  final String createdAt;
  final String updatedAt;
  final bool isComplete;
  final ParcelModel parcel;
  const TopLevelPickupParcelModel({
    required this.id,
    required this.status,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.isComplete,
    required this.parcel,
  });

  TopLevelPickupParcelModel copyWith({
    String? id,
    ParcelPickupStatus? status,
    String? note,
    String? createdAt,
    String? updatedAt,
    bool? isComplete,
    ParcelModel? parcel,
  }) {
    return TopLevelPickupParcelModel(
      id: id ?? this.id,
      status: status ?? this.status,
      note: note ?? this.note,
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
      'note': note,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      "isComplete": isComplete,
      'parcel': parcel.toMap(),
    };
  }

  factory TopLevelPickupParcelModel.fromMap(Map<String, dynamic> map) {
    return TopLevelPickupParcelModel(
      id: map['_id'] ?? '',
      status: ParcelPickupStatus.values.byName(map['status']),
      note: map["note"] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      isComplete: map["isComplete"] ?? false,
      parcel: ParcelModel.fromMap(map['parcel']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TopLevelPickupParcelModel.fromJson(String source) =>
      TopLevelPickupParcelModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(_id: $id, status: $status, note: $note createdAt: $createdAt, updatedAt: $updatedAt, isComplete $isComplete, parcel: $parcel)';
  }

  @override
  List<Object> get props {
    return [
      id,
      status,
      note,
      createdAt,
      updatedAt,
      isComplete,
      parcel,
    ];
  }
}
