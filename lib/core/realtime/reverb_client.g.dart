// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reverb_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reverbClient)
final reverbClientProvider = ReverbClientProvider._();

final class ReverbClientProvider
    extends $FunctionalProvider<ReverbClient, ReverbClient, ReverbClient>
    with $Provider<ReverbClient> {
  ReverbClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reverbClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reverbClientHash();

  @$internal
  @override
  $ProviderElement<ReverbClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReverbClient create(Ref ref) {
    return reverbClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReverbClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReverbClient>(value),
    );
  }
}

String _$reverbClientHash() => r'eec9de93adb446d1f1c72f06cd5162838963a449';
