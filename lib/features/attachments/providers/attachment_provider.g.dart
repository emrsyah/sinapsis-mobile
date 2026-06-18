// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AttachmentListNotifier)
final attachmentListProvider = AttachmentListNotifierFamily._();

final class AttachmentListNotifierProvider
    extends $AsyncNotifierProvider<AttachmentListNotifier, List<Attachment>> {
  AttachmentListNotifierProvider._({
    required AttachmentListNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'attachmentListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$attachmentListNotifierHash();

  @override
  String toString() {
    return r'attachmentListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AttachmentListNotifier create() => AttachmentListNotifier();

  @override
  bool operator ==(Object other) {
    return other is AttachmentListNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$attachmentListNotifierHash() =>
    r'704b69c9c6bf2a4d77d708b043a88c261f7d1913';

final class AttachmentListNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          AttachmentListNotifier,
          AsyncValue<List<Attachment>>,
          List<Attachment>,
          FutureOr<List<Attachment>>,
          String
        > {
  AttachmentListNotifierFamily._()
    : super(
        retry: null,
        name: r'attachmentListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AttachmentListNotifierProvider call(String noteId) =>
      AttachmentListNotifierProvider._(argument: noteId, from: this);

  @override
  String toString() => r'attachmentListProvider';
}

abstract class _$AttachmentListNotifier
    extends $AsyncNotifier<List<Attachment>> {
  late final _$args = ref.$arg as String;
  String get noteId => _$args;

  FutureOr<List<Attachment>> build(String noteId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<Attachment>>, List<Attachment>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Attachment>>, List<Attachment>>,
              AsyncValue<List<Attachment>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
