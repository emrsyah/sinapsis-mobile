// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sharing_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SharingController)
final sharingControllerProvider = SharingControllerProvider._();

final class SharingControllerProvider
    extends $NotifierProvider<SharingController, void> {
  SharingControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharingControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharingControllerHash();

  @$internal
  @override
  SharingController create() => SharingController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$sharingControllerHash() => r'0b731c52f7261c83610fb4b3bbea6b88dc0f2adb';

abstract class _$SharingController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Public shared note by token (no auth).

@ProviderFor(sharedNote)
final sharedNoteProvider = SharedNoteFamily._();

/// Public shared note by token (no auth).

final class SharedNoteProvider
    extends $FunctionalProvider<AsyncValue<Note>, Note, FutureOr<Note>>
    with $FutureModifier<Note>, $FutureProvider<Note> {
  /// Public shared note by token (no auth).
  SharedNoteProvider._({
    required SharedNoteFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'sharedNoteProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$sharedNoteHash();

  @override
  String toString() {
    return r'sharedNoteProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Note> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Note> create(Ref ref) {
    final argument = this.argument as String;
    return sharedNote(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SharedNoteProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sharedNoteHash() => r'e7d92791add90d21deeff5d421091a2633ce4782';

/// Public shared note by token (no auth).

final class SharedNoteFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Note>, String> {
  SharedNoteFamily._()
    : super(
        retry: null,
        name: r'sharedNoteProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Public shared note by token (no auth).

  SharedNoteProvider call(String token) =>
      SharedNoteProvider._(argument: token, from: this);

  @override
  String toString() => r'sharedNoteProvider';
}
