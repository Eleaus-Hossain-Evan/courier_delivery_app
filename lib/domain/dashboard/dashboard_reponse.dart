import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'dashboard_model.dart';

class DashboardResponse extends Equatable {
  final DashboardModel data;
  final bool success;
  final String message;
  const DashboardResponse({
    required this.data,
    required this.success,
    required this.message,
  });

  DashboardResponse copyWith({
    DashboardModel? data,
    bool? success,
    String? message,
  }) {
    return DashboardResponse(
      data: data ?? this.data,
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.toMap(),
      'success': success,
      'message': message,
    };
  }

  factory DashboardResponse.fromMap(Map<String, dynamic> map) {
    return DashboardResponse(
      data: DashboardModel.fromMap(map['data']),
      success: map['success'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardResponse.fromJson(String source) =>
      DashboardResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'DeshboardResponse(data: $data, success: $success, message: $message)';

  @override
  List<Object> get props => [data, success, message];
}
