// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dashboardHash() => r'8479e03edfdd8971cb60621891f7f25824feef08';

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

abstract class _$Dashboard
    extends BuildlessAutoDisposeAsyncNotifier<DashboardModel> {
  late final bool isPickup;

  Future<DashboardModel> build(
    bool isPickup,
  );
}

/// See also [Dashboard].
@ProviderFor(Dashboard)
const dashboardProvider = DashboardFamily();

/// See also [Dashboard].
class DashboardFamily extends Family<AsyncValue<DashboardModel>> {
  /// See also [Dashboard].
  const DashboardFamily();

  /// See also [Dashboard].
  DashboardProvider call(
    bool isPickup,
  ) {
    return DashboardProvider(
      isPickup,
    );
  }

  @override
  DashboardProvider getProviderOverride(
    covariant DashboardProvider provider,
  ) {
    return call(
      provider.isPickup,
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
  String? get name => r'dashboardProvider';
}

/// See also [Dashboard].
class DashboardProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Dashboard, DashboardModel> {
  /// See also [Dashboard].
  DashboardProvider(
    this.isPickup,
  ) : super.internal(
          () => Dashboard()..isPickup = isPickup,
          from: dashboardProvider,
          name: r'dashboardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dashboardHash,
          dependencies: DashboardFamily._dependencies,
          allTransitiveDependencies: DashboardFamily._allTransitiveDependencies,
        );

  final bool isPickup;

  @override
  bool operator ==(Object other) {
    return other is DashboardProvider && other.isPickup == isPickup;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, isPickup.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Future<DashboardModel> runNotifierBuild(
    covariant Dashboard notifier,
  ) {
    return notifier.build(
      isPickup,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
