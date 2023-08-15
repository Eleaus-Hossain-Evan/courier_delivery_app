// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcel_pickup_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$parcelPickupHash() => r'7a77d19cdbee384a9607fed319ede42b4a37ccf9';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ParcelPickup
    extends BuildlessAutoDisposeAsyncNotifier<List<TopLevelCommonParcelModel>> {
  late final ParcelPickupType type;
  late final int page;
  late final int limit;

  Future<List<TopLevelCommonParcelModel>> build({
    ParcelPickupType type = ParcelPickupType.assign,
    int page = 1,
    int limit = 10,
  });
}

/// See also [ParcelPickup].
@ProviderFor(ParcelPickup)
const parcelPickupProvider = ParcelPickupFamily();

/// See also [ParcelPickup].
class ParcelPickupFamily
    extends Family<AsyncValue<List<TopLevelCommonParcelModel>>> {
  /// See also [ParcelPickup].
  const ParcelPickupFamily();

  /// See also [ParcelPickup].
  ParcelPickupProvider call({
    ParcelPickupType type = ParcelPickupType.assign,
    int page = 1,
    int limit = 10,
  }) {
    return ParcelPickupProvider(
      type: type,
      page: page,
      limit: limit,
    );
  }

  @override
  ParcelPickupProvider getProviderOverride(
    covariant ParcelPickupProvider provider,
  ) {
    return call(
      type: provider.type,
      page: provider.page,
      limit: provider.limit,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'parcelPickupProvider';
}

/// See also [ParcelPickup].
class ParcelPickupProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ParcelPickup, List<TopLevelCommonParcelModel>> {
  /// See also [ParcelPickup].
  ParcelPickupProvider({
    this.type = ParcelPickupType.assign,
    this.page = 1,
    this.limit = 10,
  }) : super.internal(
          () => ParcelPickup()
            ..type = type
            ..page = page
            ..limit = limit,
          from: parcelPickupProvider,
          name: r'parcelPickupProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$parcelPickupHash,
          dependencies: ParcelPickupFamily._dependencies,
          allTransitiveDependencies:
              ParcelPickupFamily._allTransitiveDependencies,
        );

  final ParcelPickupType type;
  final int page;
  final int limit;

  @override
  bool operator ==(Object other) {
    return other is ParcelPickupProvider &&
        other.type == type &&
        other.page == page &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Future<List<TopLevelCommonParcelModel>> runNotifierBuild(
    covariant ParcelPickup notifier,
  ) {
    return notifier.build(
      type: type,
      page: page,
      limit: limit,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
