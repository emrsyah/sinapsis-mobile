// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_tool_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(studyToolRepository)
final studyToolRepositoryProvider = StudyToolRepositoryProvider._();

final class StudyToolRepositoryProvider
    extends
        $FunctionalProvider<
          StudyToolRepository,
          StudyToolRepository,
          StudyToolRepository
        >
    with $Provider<StudyToolRepository> {
  StudyToolRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'studyToolRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$studyToolRepositoryHash();

  @$internal
  @override
  $ProviderElement<StudyToolRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StudyToolRepository create(Ref ref) {
    return studyToolRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StudyToolRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StudyToolRepository>(value),
    );
  }
}

String _$studyToolRepositoryHash() =>
    r'2a0244eea8e7b5743c2d9d9bba7bce535659bae5';
