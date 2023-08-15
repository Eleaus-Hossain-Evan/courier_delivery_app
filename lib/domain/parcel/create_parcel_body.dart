import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'model/customer_info_model.dart';
import 'model/merchant_info_model.dart';
import 'model/regular_charge_model.dart';
import 'model/regular_parcel_info_model.dart';

class CreateParcelBody extends Equatable {
  final MerchantInfoModel merchantInfo;
  final CustomerInfoModel customerInfo;
  final RegularParcelInfoModel regularParcelInfo;
  final RegularPaymentModel regularPayment;
  const CreateParcelBody({
    required this.merchantInfo,
    required this.customerInfo,
    required this.regularParcelInfo,
    required this.regularPayment,
  });

  CreateParcelBody copyWith({
    MerchantInfoModel? merchantInfo,
    CustomerInfoModel? customerInfo,
    RegularParcelInfoModel? regularParcelInfo,
    RegularPaymentModel? regularPayment,
  }) {
    return CreateParcelBody(
      merchantInfo: merchantInfo ?? this.merchantInfo,
      customerInfo: customerInfo ?? this.customerInfo,
      regularParcelInfo: regularParcelInfo ?? this.regularParcelInfo,
      regularPayment: regularPayment ?? this.regularPayment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'merchantInfo': merchantInfo.toMap(),
      'customerInfo': customerInfo.toMap(),
      'regularParcelInfo': regularParcelInfo.toMap(),
      'regularPayment': regularPayment.toMap(),
    };
  }

  factory CreateParcelBody.fromMap(Map<String, dynamic> map) {
    return CreateParcelBody(
      merchantInfo: MerchantInfoModel.fromMap(map['merchantInfo']),
      customerInfo: CustomerInfoModel.fromMap(map['customerInfo']),
      regularParcelInfo:
          RegularParcelInfoModel.fromMap(map['regularParcelInfo']),
      regularPayment: RegularPaymentModel.fromMap(map['regularPayment']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateParcelBody.fromJson(String source) =>
      CreateParcelBody.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateParcelBody(merchantInfo: $merchantInfo, customerInfo: $customerInfo, regularParcelInfo: $regularParcelInfo, regularPayment: $regularPayment)';
  }

  @override
  List<Object> get props =>
      [merchantInfo, customerInfo, regularParcelInfo, regularPayment];
}
