import 'dart:convert';

import 'package:equatable/equatable.dart';

class MetaDataModel extends Equatable {
  final int totalData;
  final int page;
  final int limit;
  final int totalPage;

  const MetaDataModel({
    required this.totalData,
    required this.page,
    required this.limit,
    required this.totalPage,
  });

  factory MetaDataModel.init() =>
      const MetaDataModel(totalData: 0, page: 0, limit: 0, totalPage: 0);

  MetaDataModel copyWith({
    int? totalData,
    int? page,
    int? limit,
    int? totalPage,
  }) {
    return MetaDataModel(
      totalData: totalData ?? this.totalData,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      totalPage: totalPage ?? this.totalPage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalData': totalData,
      'page': page,
      'limit': limit,
      'totalPage': totalPage,
    };
  }

  factory MetaDataModel.fromMap(Map<String, dynamic> map) {
    return MetaDataModel(
      totalData: map['totalData']?.toInt() ?? 0,
      page: map['page']?.toInt() ?? 0,
      limit: map['limit']?.toInt() ?? 0,
      totalPage: map['totalPage']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MetaDataModel.fromJson(String source) =>
      MetaDataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MetaDataModel(totalData: $totalData, page: $page, limit: $limit, totalPage: $totalPage)';
  }

  @override
  List<Object> get props => [totalData, page, limit, totalPage];
}
