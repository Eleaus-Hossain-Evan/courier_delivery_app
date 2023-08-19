import 'package:equatable/equatable.dart';

import '../../domain/parcel/parcel_pickup_list_response.dart';

class ParcelPickupState extends Equatable {
  final bool loading;
  final ParcelPickupListResponse parcelPickupResponse;

  const ParcelPickupState({
    required this.loading,
    required this.parcelPickupResponse,
  });

  factory ParcelPickupState.init() => ParcelPickupState(
        loading: false,
        parcelPickupResponse: ParcelPickupListResponse.init(),
      );

  ParcelPickupState copyWith({
    bool? loading,
    ParcelPickupListResponse? parcelPickupResponse,
  }) {
    return ParcelPickupState(
      loading: loading ?? this.loading,
      parcelPickupResponse: parcelPickupResponse ?? this.parcelPickupResponse,
    );
  }

  @override
  String toString() =>
      'ParcelPickupState(loading: $loading, parcelPickupResponse: $parcelPickupResponse)';

  @override
  List<Object> get props => [loading, parcelPickupResponse];
}
