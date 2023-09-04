enum Role { rider, pickupman }

enum ParcelRiderType { all, assign, complete, reject }

enum ParcelRiderStatus { none, dropoff, partial, returns }

extension ParcelRiderStatusExt on ParcelRiderStatus {
  String get value {
    switch (this) {
      case ParcelRiderStatus.none:
        return "";
      case ParcelRiderStatus.dropoff:
        return "dropoff";
      case ParcelRiderStatus.partial:
        return "partial";
      case ParcelRiderStatus.returns:
        return "return";
    }
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
