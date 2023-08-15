import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'customer_info_model.dart';
import 'merchant_info_model.dart';
import 'regular_charge_model.dart';
import 'regular_parcel_info_model.dart';

class ParcelModel extends Equatable {
  final MerchantInfoModel merchantInfo;//
  final RegularParcelInfoModel regularParcelInfo;//
  final RegularParcelInfoModel exchangeParcelInfo;//
  final RegularPaymentModel regularPayment;//
  final RegularPaymentModel exchangePayment;//
  final String createdBy;
  final String merchantId;
  final String parcelType;
  final String pickupStatus;
  final bool isTransferMode;
  final String regularStatus;
  final String exchangeStatus;
  final int merchantUpdate;
  final String id;
  final CustomerInfoModel customerInfo;//
  final String sourceHubId;
  final String currentHubId;
  final String destinationHubId;
  final List<StatusLog> regularStatusLogs;
  final List<StatusLog> adminLogs;
  final String serialId;
  final String qrCode;
  final List<dynamic> exchangeStatusLogs;
  final String createdAt;
  final String updatedAt;

  const ParcelModel({
    required this.merchantInfo,
    required this.regularParcelInfo,
    required this.exchangeParcelInfo,
    required this.regularPayment,
    required this.exchangePayment,
    required this.createdBy,
    required this.merchantId,
    required this.parcelType,
    required this.pickupStatus,
    required this.isTransferMode,
    required this.regularStatus,
    required this.exchangeStatus,
    required this.merchantUpdate,
    required this.id,
    required this.customerInfo,
    required this.sourceHubId,
    required this.currentHubId,
    required this.destinationHubId,
    required this.regularStatusLogs,
    required this.adminLogs,
    required this.serialId,
    required this.qrCode,
    required this.exchangeStatusLogs,
    required this.createdAt,
    required this.updatedAt,
  });

  ParcelModel copyWith({
    MerchantInfoModel? merchantInfo,
    RegularParcelInfoModel? regularParcelInfo,
    RegularParcelInfoModel? exchangeParcelInfo,
    RegularPaymentModel? regularPayment,
    RegularPaymentModel? exchangePayment,
    String? createdBy,
    String? merchantId,
    String? parcelType,
    String? pickupStatus,
    bool? isTransferMode,
    String? regularStatus,
    String? exchangeStatus,
    int? merchantUpdate,
    String? id,
    CustomerInfoModel? customerInfo,
    String? sourceHubId,
    String? currentHubId,
    String? destinationHubId,
    List<StatusLog>? regularStatusLogs,
    List<StatusLog>? adminLogs,
    String? serialId,
    String? qrCode,
    List<dynamic>? exchangeStatusLogs,
    String? createdAt,
    String? updatedAt,
  }) {
    return ParcelModel(
      merchantInfo: merchantInfo ?? this.merchantInfo,
      regularParcelInfo: regularParcelInfo ?? this.regularParcelInfo,
      exchangeParcelInfo: exchangeParcelInfo ?? this.exchangeParcelInfo,
      regularPayment: regularPayment ?? this.regularPayment,
      exchangePayment: exchangePayment ?? this.exchangePayment,
      createdBy: createdBy ?? this.createdBy,
      merchantId: merchantId ?? this.merchantId,
      parcelType: parcelType ?? this.parcelType,
      pickupStatus: pickupStatus ?? this.pickupStatus,
      isTransferMode: isTransferMode ?? this.isTransferMode,
      regularStatus: regularStatus ?? this.regularStatus,
      exchangeStatus: exchangeStatus ?? this.exchangeStatus,
      merchantUpdate: merchantUpdate ?? this.merchantUpdate,
      id: id ?? this.id,
      customerInfo: customerInfo ?? this.customerInfo,
      sourceHubId: sourceHubId ?? this.sourceHubId,
      currentHubId: currentHubId ?? this.currentHubId,
      destinationHubId: destinationHubId ?? this.destinationHubId,
      regularStatusLogs: regularStatusLogs ?? this.regularStatusLogs,
      adminLogs: adminLogs ?? this.adminLogs,
      serialId: serialId ?? this.serialId,
      qrCode: qrCode ?? this.qrCode,
      exchangeStatusLogs: exchangeStatusLogs ?? this.exchangeStatusLogs,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'merchantInfo': merchantInfo.toMap(),
      'regularParcelInfo': regularParcelInfo.toMap(),
      'exchangeParcelInfo': exchangeParcelInfo.toMap(),
      'regularPayment': regularPayment.toMap(),
      'exchangePayment': exchangePayment.toMap(),
      'createdBy': createdBy,
      'merchantId': merchantId,
      'parcelType': parcelType,
      'pickupStatus': pickupStatus,
      'isTransferMode': isTransferMode,
      'regularStatus': regularStatus,
      'exchangeStatus': exchangeStatus,
      'merchantUpdate': merchantUpdate,
      '_id': id,
      'customerInfo': customerInfo.toMap(),
      'sourceHubId': sourceHubId,
      'currentHubId': currentHubId,
      'destinationHubId': destinationHubId,
      'regularStatusLogs': regularStatusLogs.map((x) => x.toMap()).toList(),
      'adminLogs': adminLogs.map((x) => x.toMap()).toList(),
      'serialId': serialId,
      'qrCode': qrCode,
      'exchangeStatusLogs': exchangeStatusLogs,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ParcelModel.fromMap(Map<String, dynamic> map) {
    return ParcelModel(
      merchantInfo: map['merchantInfo'] != null
          ? MerchantInfoModel.fromMap(map['merchantInfo'])
          : MerchantInfoModel.init(),
      regularParcelInfo: map['regularParcelInfo'] != null
          ? RegularParcelInfoModel.fromMap(map['regularParcelInfo'])
          : RegularParcelInfoModel.init(),
      exchangeParcelInfo: map['exchangeParcelInfo'] != null
          ? RegularParcelInfoModel.fromMap(map['exchangeParcelInfo'])
          : RegularParcelInfoModel.init(),
      regularPayment: map['regularPayment'] != null
          ? RegularPaymentModel.fromMap(map['regularPayment'])
          : RegularPaymentModel.init(),
      exchangePayment: map['exchangePayment'] != null
          ? RegularPaymentModel.fromMap(map['exchangePayment'])
          : RegularPaymentModel.init(),
      createdBy: map['createdBy'] ?? '',
      merchantId: map['merchantId'] ?? '',
      parcelType: map['parcelType'] ?? '',
      pickupStatus: map['pickupStatus'] ?? '',
      isTransferMode: map['isTransferMode'] ?? false,
      regularStatus: map['regularStatus'] ?? '',
      exchangeStatus: map['exchangeStatus'] ?? '',
      merchantUpdate: map['merchantUpdate']?.toInt() ?? 0,
      id: map['_id'] ?? '',
      customerInfo: map['customerInfo'] != null
          ? CustomerInfoModel.fromMap(map['customerInfo'])
          : CustomerInfoModel.init(),
      sourceHubId: map['sourceHubId'] ?? '',
      currentHubId: map['currentHubId'] ?? '',
      destinationHubId: map['destinationHubId'] ?? '',
      regularStatusLogs: List<StatusLog>.from(
          map['regularStatusLogs']?.map((x) => StatusLog.fromMap(x)) ??
              const []),
      adminLogs: List<StatusLog>.from(
          map['adminLogs']?.map((x) => StatusLog.fromMap(x)) ?? const []),
      serialId: map['serialId'] ?? '',
      qrCode: map['qrCode'] ?? '',
      exchangeStatusLogs: List<StatusLog>.from(
          map['exchangeStatusLogs']?.map((x) => StatusLog.fromMap(x)) ??
              const []),
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ParcelModel.fromJson(String source) =>
      ParcelModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(merchantInfo: $merchantInfo, regularParcelInfo: $regularParcelInfo, exchangeParcelInfo: $exchangeParcelInfo, regularPayment: $regularPayment, exchangePayment: $exchangePayment, createdBy: $createdBy, merchantId: $merchantId, parcelType: $parcelType, pickupStatus: $pickupStatus, isTransferMode: $isTransferMode, regularStatus: $regularStatus, exchangeStatus: $exchangeStatus, merchantUpdate: $merchantUpdate, _id: $id, customerInfo: $customerInfo, sourceHubId: $sourceHubId, currentHubId: $currentHubId, destinationHubId: $destinationHubId, regularStatusLogs: $regularStatusLogs, adminLogs: $adminLogs, serialId: $serialId, qrCode: $qrCode, exchangeStatusLogs: $exchangeStatusLogs, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      merchantInfo,
      regularParcelInfo,
      exchangeParcelInfo,
      regularPayment,
      exchangePayment,
      createdBy,
      merchantId,
      parcelType,
      pickupStatus,
      isTransferMode,
      regularStatus,
      exchangeStatus,
      merchantUpdate,
      id,
      customerInfo,
      sourceHubId,
      currentHubId,
      destinationHubId,
      regularStatusLogs,
      adminLogs,
      serialId,
      qrCode,
      exchangeStatusLogs,
      createdAt,
      updatedAt,
    ];
  }
}

class StatusLog extends Equatable {
  final String time;
  final String id;
  final String log;
  const StatusLog({
    required this.time,
    required this.id,
    required this.log,
  });

  StatusLog copyWith({
    String? time,
    String? id,
    String? log,
  }) {
    return StatusLog(
      time: time ?? this.time,
      id: id ?? this.id,
      log: log ?? this.log,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      '_id': id,
      'log': log,
    };
  }

  factory StatusLog.fromMap(Map<String, dynamic> map) {
    return StatusLog(
      time: map['time'] ?? '',
      id: map['_id'] ?? '',
      log: map['log'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusLog.fromJson(String source) =>
      StatusLog.fromMap(json.decode(source));

  @override
  String toString() => 'RegularStatusLog(time: $time, _id: $id, log: $log)';

  @override
  List<Object> get props => [time, id, log];
}
