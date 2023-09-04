import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:courier_delivery_app/domain/auth/model/salary_model.dart';

import '../../../utils/utils.dart';
import 'bank_account_model.dart';
import 'hub_model.dart';
import 'other_account_model.dart';

class UserModel extends Equatable {
  final String id;
  final String serialId; //
  final String address; //
  final String image; //
  final int salary; //
  final String defaultPayment; //
  final bool isDisabled;
  final Role role;
  final String name;
  final String email;
  final String phone;
  final BankAccountModel bankAccount;
  final OthersAccountModel othersAccount;
  final List<SalaryModel> salaryHistory;
  final String createdAt;
  final String updatedAt;
  final HubModel hub;
  final String token;

  const UserModel({
    required this.id,
    required this.serialId,
    required this.address,
    required this.image,
    required this.salary,
    required this.defaultPayment,
    required this.isDisabled,
    required this.role,
    required this.name,
    required this.email,
    required this.phone,
    required this.bankAccount,
    required this.othersAccount,
    required this.salaryHistory,
    required this.createdAt,
    required this.updatedAt,
    required this.hub,
    required this.token,
  });

  factory UserModel.init() => UserModel(
        id: '',
        serialId: '',
        address: '',
        image: '',
        salary: 0,
        defaultPayment: '',
        isDisabled: false,
        role: Role.rider,
        name: '',
        email: '',
        phone: '',
        bankAccount: BankAccountModel.init(),
        othersAccount: OthersAccountModel.init(),
        salaryHistory: const [],
        createdAt: '',
        updatedAt: '',
        hub: HubModel.init(),
        token: '',
      );

  UserModel copyWith({
    String? id,
    String? serialId,
    String? address,
    String? image,
    int? salary,
    String? defaultPayment,
    bool? isDisabled,
    Role? role,
    String? name,
    String? email,
    String? phone,
    BankAccountModel? bankAccount,
    OthersAccountModel? othersAccount,
    List<SalaryModel>? salaryHistory,
    String? createdAt,
    String? updatedAt,
    HubModel? hub,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      serialId: serialId ?? this.serialId,
      address: address ?? this.address,
      image: image ?? this.image,
      salary: salary ?? this.salary,
      defaultPayment: defaultPayment ?? this.defaultPayment,
      isDisabled: isDisabled ?? this.isDisabled,
      role: role ?? this.role,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bankAccount: bankAccount ?? this.bankAccount,
      othersAccount: othersAccount ?? this.othersAccount,
      salaryHistory: salaryHistory ?? this.salaryHistory,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      hub: hub ?? this.hub,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'serialId': serialId,
      'address': address,
      'image': image,
      'salary': salary,
      'defaultPayment': defaultPayment,
      'isDisabled': isDisabled,
      'role': role.name,
      'name': name,
      'email': email,
      'phone': phone,
      'bankAccount': bankAccount.toMap(),
      'othersAccount': othersAccount.toMap(),
      'salaryHistory': salaryHistory.map((x) => x.toMap()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'hub': hub.toMap(),
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      serialId: map['serialId'] ?? '',
      address: map['address'] ?? '',
      image: map['image'] ?? '',
      salary: map['salary']?.toInt() ?? 0,
      defaultPayment: map['defaultPayment'] ?? '',
      isDisabled: map['isDisabled'] ?? false,
      role: Role.values.byName(map['role']),
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      bankAccount: BankAccountModel.fromMap(map['bankAccount']),
      othersAccount: OthersAccountModel.fromMap(map['othersAccount']),
      salaryHistory: List<SalaryModel>.from(
          map['salaryHistory']?.map((x) => SalaryModel.fromMap(x)) ?? const []),
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      hub: map['hub'] != null ? HubModel.fromMap(map['hub']) : HubModel.init(),
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, serialId: $serialId, address: $address, image: $image, salary: $salary, defaultPayment: $defaultPayment, isDisabled: $isDisabled, role: $role, name: $name, email: $email, phone: $phone, bankAccount: $bankAccount, othersAccount: $othersAccount, salaryHistory: $salaryHistory, createdAt: $createdAt, updatedAt: $updatedAt, hub: $hub, token: $token)';
  }

  @override
  List<Object> get props {
    return [
      id,
      serialId,
      address,
      image,
      salary,
      defaultPayment,
      isDisabled,
      role,
      name,
      email,
      phone,
      bankAccount,
      othersAccount,
      salaryHistory,
      createdAt,
      updatedAt,
      hub,
      token,
    ];
  }
}
