// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TagListNotifier)
final tagListProvider = TagListNotifierProvider._();

final class TagListNotifierProvider
    extends $AsyncNotifierProvider<TagListNotifier, List<Tag>> {
  TagListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tagListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tagListNotifierHash();

  @$internal
  @override
  TagListNotifier create() => TagListNotifier();
}

String _$tagListNotifierHash() => r'63c5e40c944d98e0a961b51bc4a0147379e26f22';

abstract class _$TagListNotifier extends $AsyncNotifier<List<Tag>> {
  FutureOr<List<Tag>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Tag>>, List<Tag>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Tag>>, List<Tag>>,
              AsyncValue<List<Tag>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
