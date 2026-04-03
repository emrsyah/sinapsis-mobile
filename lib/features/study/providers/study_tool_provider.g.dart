// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_tool_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(studyToolList)
final studyToolListProvider = StudyToolListFamily._();

final class StudyToolListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<StudyToolGeneration>>,
          List<StudyToolGeneration>,
          FutureOr<List<StudyToolGeneration>>
        >
    with
        $FutureModifier<List<StudyToolGeneration>>,
        $FutureProvider<List<StudyToolGeneration>> {
  StudyToolListProvider._({
    required StudyToolListFamily super.from,
    required (String, {String? type}) super.argument,
  }) : super(
         retry: null,
         name: r'studyToolListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$studyToolListHash();

  @override
  String toString() {
    return r'studyToolListProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<StudyToolGeneration>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<StudyToolGeneration>> create(Ref ref) {
    final argument = this.argument as (String, {String? type});
    return studyToolList(ref, argument.$1, type: argument.type);
  }

  @override
  bool operator ==(Object other) {
    return other is StudyToolListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$studyToolListHash() => r'cd5e746072954357abfb5b5f68fa887bf4f0839a';

final class StudyToolListFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<StudyToolGeneration>>,
          (String, {String? type})
        > {
  StudyToolListFamily._()
    : super(
        retry: null,
        name: r'studyToolListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StudyToolListProvider call(String noteId, {String? type}) =>
      StudyToolListProvider._(argument: (noteId, type: type), from: this);

  @override
  String toString() => r'studyToolListProvider';
}

@ProviderFor(studyToolDetail)
final studyToolDetailProvider = StudyToolDetailFamily._();

final class StudyToolDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<StudyToolGeneration>,
          StudyToolGeneration,
          FutureOr<StudyToolGeneration>
        >
    with
        $FutureModifier<StudyToolGeneration>,
        $FutureProvider<StudyToolGeneration> {
  StudyToolDetailProvider._({
    required StudyToolDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'studyToolDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$studyToolDetailHash();

  @override
  String toString() {
    return r'studyToolDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<StudyToolGeneration> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<StudyToolGeneration> create(Ref ref) {
    final argument = this.argument as String;
    return studyToolDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is StudyToolDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$studyToolDetailHash() => r'f445146d7148891031cbb794a9f993c49e8903fa';

final class StudyToolDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<StudyToolGeneration>, String> {
  StudyToolDetailFamily._()
    : super(
        retry: null,
        name: r'studyToolDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StudyToolDetailProvider call(String id) =>
      StudyToolDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'studyToolDetailProvider';
}
