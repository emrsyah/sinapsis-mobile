// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NoteListNotifier)
final noteListProvider = NoteListNotifierFamily._();

final class NoteListNotifierProvider
    extends $AsyncNotifierProvider<NoteListNotifier, List<Note>> {
  NoteListNotifierProvider._({
    required NoteListNotifierFamily super.from,
    required ({String? folderId, String? tagId, bool inTrash}) super.argument,
  }) : super(
         retry: null,
         name: r'noteListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$noteListNotifierHash();

  @override
  String toString() {
    return r'noteListProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  NoteListNotifier create() => NoteListNotifier();

  @override
  bool operator ==(Object other) {
    return other is NoteListNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$noteListNotifierHash() => r'4518acbb34c9d86281bb1e54cfa6871f983d32e6';

final class NoteListNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          NoteListNotifier,
          AsyncValue<List<Note>>,
          List<Note>,
          FutureOr<List<Note>>,
          ({String? folderId, String? tagId, bool inTrash})
        > {
  NoteListNotifierFamily._()
    : super(
        retry: null,
        name: r'noteListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  NoteListNotifierProvider call({
    String? folderId,
    String? tagId,
    bool inTrash = false,
  }) => NoteListNotifierProvider._(
    argument: (folderId: folderId, tagId: tagId, inTrash: inTrash),
    from: this,
  );

  @override
  String toString() => r'noteListProvider';
}

abstract class _$NoteListNotifier extends $AsyncNotifier<List<Note>> {
  late final _$args =
      ref.$arg as ({String? folderId, String? tagId, bool inTrash});
  String? get folderId => _$args.folderId;
  String? get tagId => _$args.tagId;
  bool get inTrash => _$args.inTrash;

  FutureOr<List<Note>> build({
    String? folderId,
    String? tagId,
    bool inTrash = false,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Note>>, List<Note>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Note>>, List<Note>>,
              AsyncValue<List<Note>>,
              Object?,
              Object?
            >;
    element.handleCreate(
      ref,
      () => build(
        folderId: _$args.folderId,
        tagId: _$args.tagId,
        inTrash: _$args.inTrash,
      ),
    );
  }
}

@ProviderFor(noteDetail)
final noteDetailProvider = NoteDetailFamily._();

final class NoteDetailProvider
    extends $FunctionalProvider<AsyncValue<Note>, Note, FutureOr<Note>>
    with $FutureModifier<Note>, $FutureProvider<Note> {
  NoteDetailProvider._({
    required NoteDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'noteDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$noteDetailHash();

  @override
  String toString() {
    return r'noteDetailProvider'
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
    return noteDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is NoteDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$noteDetailHash() => r'365a15d2d89336f5e43ef2c304df7f49dba8b76a';

final class NoteDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Note>, String> {
  NoteDetailFamily._()
    : super(
        retry: null,
        name: r'noteDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  NoteDetailProvider call(String id) =>
      NoteDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'noteDetailProvider';
}
