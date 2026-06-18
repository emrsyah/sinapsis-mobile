// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(attachmentRepository)
final attachmentRepositoryProvider = AttachmentRepositoryProvider._();

final class AttachmentRepositoryProvider
    extends
        $FunctionalProvider<
          AttachmentRepository,
          AttachmentRepository,
          AttachmentRepository
        >
    with $Provider<AttachmentRepository> {
  AttachmentRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'attachmentRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$attachmentRepositoryHash();

  @$internal
  @override
  $ProviderElement<AttachmentRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AttachmentRepository create(Ref ref) {
    return attachmentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AttachmentRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AttachmentRepository>(value),
    );
  }
}

String _$attachmentRepositoryHash() =>
    r'4647f2a42e86c750f139fa9f6acf380affe4bae2';
