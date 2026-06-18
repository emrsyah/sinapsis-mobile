// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(aiClient)
final aiClientProvider = AiClientProvider._();

final class AiClientProvider
    extends $FunctionalProvider<AiClient, AiClient, AiClient>
    with $Provider<AiClient> {
  AiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiClientHash();

  @$internal
  @override
  $ProviderElement<AiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AiClient create(Ref ref) {
    return aiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AiClient>(value),
    );
  }
}

String _$aiClientHash() => r'1138c8e73366336a42b02daae65a87b9a85b048c';
