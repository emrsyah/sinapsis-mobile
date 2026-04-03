// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FolderListNotifier)
final folderListProvider = FolderListNotifierProvider._();

final class FolderListNotifierProvider
    extends $AsyncNotifierProvider<FolderListNotifier, List<Folder>> {
  FolderListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'folderListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$folderListNotifierHash();

  @$internal
  @override
  FolderListNotifier create() => FolderListNotifier();
}

String _$folderListNotifierHash() =>
    r'f882eccb325dc98a844f34e1052ebc29fac51eaa';

abstract class _$FolderListNotifier extends $AsyncNotifier<List<Folder>> {
  FutureOr<List<Folder>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Folder>>, List<Folder>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Folder>>, List<Folder>>,
              AsyncValue<List<Folder>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
