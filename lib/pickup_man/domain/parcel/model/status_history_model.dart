import 'dart:convert';

import 'package:equatable/equatable.dart';

class StatusHistoryModel extends Equatable {
  final String time;
  final String id;
  final String statusBy;
  final String status;
  const StatusHistoryModel({
    required this.time,
    required this.id,
    required this.statusBy,
    required this.status,
  });

  StatusHistoryModel copyWith({
    String? time,
    String? id,
    String? statusBy,
    String? status,
  }) {
    return StatusHistoryModel(
      time: time ?? this.time,
      id: id ?? this.id,
      statusBy: statusBy ?? this.statusBy,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      '_id': id,
      'statusBy': statusBy,
      'status': status,
    };
  }

  factory StatusHistoryModel.fromMap(Map<String, dynamic> map) {
    return StatusHistoryModel(
      time: map['time'] ?? '',
      id: map['_id'] ?? '',
      statusBy: map['statusBy'] ?? '',
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusHistoryModel.fromJson(String source) =>
      StatusHistoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StatusHistory(time: $time, _id: $id, statusBy: $statusBy, status: $status)';
  }

  @override
  List<Object> get props => [time, id, statusBy, status];
}
