import 'dart:convert';

import 'package:equatable/equatable.dart';

class RegularPaymentModel extends Equatable {
  final double cashCollection;
  final double deliveryCharge;
  final double codCharge;
  final double weightCharge;
  final double totalCharge;

  const RegularPaymentModel({
    required this.cashCollection,
    required this.deliveryCharge,
    required this.codCharge,
    required this.weightCharge,
    required this.totalCharge,
  });

  factory RegularPaymentModel.init() => const RegularPaymentModel(
      cashCollection: 00,
      deliveryCharge: 0,
      codCharge: 0,
      weightCharge: 0,
      totalCharge: 0);

  RegularPaymentModel copyWith({
    double? cashCollection,
    double? deliveryCharge,
    double? codCharge,
    double? weightCharge,
    double? totalCharge,
  }) {
    return RegularPaymentModel(
      cashCollection: cashCollection ?? this.cashCollection,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      codCharge: codCharge ?? this.codCharge,
      weightCharge: weightCharge ?? this.weightCharge,
      totalCharge: totalCharge ?? this.totalCharge,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cashCollection': cashCollection,
      'deliveryCharge': deliveryCharge,
      'codCharge': codCharge,
      'weightCharge': weightCharge,
      'totalCharge': totalCharge,
    };
  }

  factory RegularPaymentModel.fromMap(Map<String, dynamic> map) {
    return RegularPaymentModel(
      cashCollection: map['cashCollection']?.toDouble() ?? 0.0,
      deliveryCharge: map['deliveryCharge']?.toDouble() ?? 0.0,
      codCharge: map['codCharge']?.toDouble() ?? 0.0,
      weightCharge: map['weightCharge']?.toDouble() ?? 0.0,
      totalCharge: map['totalCharge']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegularPaymentModel.fromJson(String source) =>
      RegularPaymentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RegularPayment(cashCollection: $cashCollection, deliveryCharge: $deliveryCharge, codCharge: $codCharge, weightCharge: $weightCharge, totalCharge: $totalCharge)';
  }

  @override
  List<Object> get props {
    return [
      cashCollection,
      deliveryCharge,
      codCharge,
      weightCharge,
      totalCharge,
    ];
  }
}
