enum Role { rider, pickupman }

enum ParcelRiderType { all, assign, complete, reject }

enum ParcelRiderStatus { none, dropoff, partial, hold, returns }

extension ParcelRiderStatusExt on ParcelRiderStatus {
  String get value {
    return switch (this) {
      ParcelRiderStatus.none => "",
      ParcelRiderStatus.dropoff => "dropoff",
      ParcelRiderStatus.partial => "partial",
      ParcelRiderStatus.hold => "hold",
      ParcelRiderStatus.returns => "return",
    };
  }
}

enum ParcelPickupStatus { all, assign, received, cancel }

enum ParcelMaterialType { regular, fragile, liquid, none }

extension ParcelMaterialTypeExt on ParcelMaterialType {
  String get value {
    switch (this) {
      case ParcelMaterialType.none:
        return "";
      case ParcelMaterialType.regular:
        return "regular";
      case ParcelMaterialType.fragile:
        return "fragile";
      case ParcelMaterialType.liquid:
        return "liquid";
    }
  }
}
