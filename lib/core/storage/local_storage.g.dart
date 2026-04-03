// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localStorage)
final localStorageProvider = LocalStorageProvider._();

final class LocalStorageProvider
    extends $FunctionalProvider<LocalStorage, LocalStorage, LocalStorage>
    with $Provider<LocalStorage> {
  LocalStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localStorageHash();

  @$internal
  @override
  $ProviderElement<LocalStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalStorage create(Ref ref) {
    return localStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalStorage>(value),
    );
  }
}

String _$localStorageHash() => r'd2221502481ed9cfd0fd0ad5d3d933a68cc4daf7';
