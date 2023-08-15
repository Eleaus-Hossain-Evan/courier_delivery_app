import 'dart:convert';

import 'package:equatable/equatable.dart';

class OthersAccountModel extends Equatable {
  final String bkashNum;
  final String rocketNum;
  final String nagadNum;

  const OthersAccountModel({
    required this.bkashNum,
    required this.rocketNum,
    required this.nagadNum,
  });

  factory OthersAccountModel.init() =>
      const OthersAccountModel(bkashNum: '', rocketNum: '', nagadNum: '');

  OthersAccountModel copyWith({
    String? bkashNum,
    String? rocketNum,
    String? nagadNum,
  }) {
    return OthersAccountModel(
      bkashNum: bkashNum ?? this.bkashNum,
      rocketNum: rocketNum ?? this.rocketNum,
      nagadNum: nagadNum ?? this.nagadNum,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bkashNum': bkashNum,
      'rocketNum': rocketNum,
      'nagadNum': nagadNum,
    };
  }

  factory OthersAccountModel.fromMap(Map<String, dynamic> map) {
    return OthersAccountModel(
      bkashNum: map['bkashNum'] ?? '',
      rocketNum: map['rocketNum'] ?? '',
      nagadNum: map['nagadNum'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OthersAccountModel.fromJson(String source) =>
      OthersAccountModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'OthersAccount(bkashNum: $bkashNum, rocketNum: $rocketNum, nagadNum: $nagadNum)';

  @override
  List<Object> get props => [bkashNum, rocketNum, nagadNum];
}
