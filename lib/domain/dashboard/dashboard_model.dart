import 'dart:convert';

import 'package:equatable/equatable.dart';

class DashboardModel extends Equatable {
  final int tAssign;
  final int tComplete;
  final int tReject;
  const DashboardModel({
    required this.tAssign,
    required this.tComplete,
    required this.tReject,
  });

  DashboardModel copyWith({
    int? tAssign,
    int? tComplete,
    int? tReject,
  }) {
    return DashboardModel(
      tAssign: tAssign ?? this.tAssign,
      tComplete: tComplete ?? this.tComplete,
      tReject: tReject ?? this.tReject,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tAssign': tAssign,
      'tComplete': tComplete,
      'tReject': tReject,
    };
  }

  factory DashboardModel.fromMap(Map<String, dynamic> map) {
    return DashboardModel(
      tAssign: map['tAssign']?.toInt() ?? 0,
      tComplete: map['tComplete']?.toInt() ?? 0,
      tReject: map['tReject']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardModel.fromJson(String source) =>
      DashboardModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'Data(tAssign: $tAssign, tComplete: $tComplete, tReject: $tReject)';

  @override
  List<Object> get props => [tAssign, tComplete, tReject];
}
