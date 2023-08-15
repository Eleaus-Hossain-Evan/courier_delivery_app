import 'dart:convert';

import 'package:equatable/equatable.dart';

class HubModel extends Equatable {
  final String id;
  final String address;
  final String name;

  const HubModel({
    required this.id,
    required this.address,
    required this.name,
  });

  factory HubModel.init() => const HubModel(id: '', address: '', name: '');

  HubModel copyWith({
    String? id,
    String? address,
    String? name,
  }) {
    return HubModel(
      id: id ?? this.id,
      address: address ?? this.address,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'name': name,
    };
  }

  factory HubModel.fromMap(Map<String, dynamic> map) {
    return HubModel(
      id: map['id'] ?? '',
      address: map['address'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HubModel.fromJson(String source) =>
      HubModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HubModel(id: $id, address: $address, name: $name)';
  }

  @override
  List<Object> get props => [id, address, name];
}
