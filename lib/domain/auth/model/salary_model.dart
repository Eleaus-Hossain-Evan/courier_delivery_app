import 'dart:convert';

import 'package:equatable/equatable.dart';

class SalaryModel extends Equatable {
  final String id;
  final int salary;
  final String message;
  final String time;

  const SalaryModel({
    required this.salary,
    required this.message,
    required this.time,
    required this.id,
  });

  factory SalaryModel.init() =>
      const SalaryModel(salary: 0, message: '', time: '', id: '');

  SalaryModel copyWith({
    int? salary,
    String? message,
    String? time,
    String? id,
  }) {
    return SalaryModel(
      salary: salary ?? this.salary,
      message: message ?? this.message,
      time: time ?? this.time,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'salary': salary,
      'message': message,
      'time': time,
      '_id': id,
    };
  }

  factory SalaryModel.fromMap(Map<String, dynamic> map) {
    return SalaryModel(
      salary: map['salary']?.toInt() ?? 0,
      message: map['message'] ?? '',
      time: map['time'] ?? '',
      id: map['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SalaryModel.fromJson(String source) =>
      SalaryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SalaryModel(salary: $salary, message: $message, time: $time, _id: $id)';
  }

  @override
  List<Object> get props => [salary, message, time, id];
}
