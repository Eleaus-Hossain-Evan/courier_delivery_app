import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:courier_delivery_app/rider/domain/parcel_pickup_list_response.dart';

class ParcelRiderState extends Equatable {
  final bool loading;
  final ParcelRiderListResponse parcelRiderResponse;

  const ParcelRiderState({
    required this.loading,
    required this.parcelRiderResponse,
  });

  factory ParcelRiderState.init() => ParcelRiderState(
        loading: false,
        parcelRiderResponse: ParcelRiderListResponse.init(),
      );

  ParcelRiderState copyWith({
    bool? loading,
    ParcelRiderListResponse? parcelRiderResponse,
  }) {
    return ParcelRiderState(
      loading: loading ?? this.loading,
      parcelRiderResponse: parcelRiderResponse ?? this.parcelRiderResponse,
    );
  }

  @override
  String toString() =>
      'ParcelRiderState(loading: $loading, parcelRiderResponse: $parcelRiderResponse)';

  @override
  List<Object> get props => [loading, parcelRiderResponse];

  Map<String, dynamic> toMap() {
    return {
      'loading': loading,
      'parcelRiderResponse': parcelRiderResponse.toMap(),
    };
  }

  factory ParcelRiderState.fromMap(Map<String, dynamic> map) {
    return ParcelRiderState(
      loading: map['loading'] ?? false,
      parcelRiderResponse:
          ParcelRiderListResponse.fromMap(map['parcelRiderResponse']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ParcelRiderState.fromJson(String source) =>
      ParcelRiderState.fromMap(json.decode(source));
}
