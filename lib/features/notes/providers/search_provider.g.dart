// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Full-text note search. Returns an empty list for blank queries so the UI
/// can render an idle/empty state without hitting the network.

@ProviderFor(searchNotes)
final searchNotesProvider = SearchNotesFamily._();

/// Full-text note search. Returns an empty list for blank queries so the UI
/// can render an idle/empty state without hitting the network.

final class SearchNotesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Note>>,
          List<Note>,
          FutureOr<List<Note>>
        >
    with $FutureModifier<List<Note>>, $FutureProvider<List<Note>> {
  /// Full-text note search. Returns an empty list for blank queries so the UI
  /// can render an idle/empty state without hitting the network.
  SearchNotesProvider._({
    required SearchNotesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'searchNotesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchNotesHash();

  @override
  String toString() {
    return r'searchNotesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Note>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Note>> create(Ref ref) {
    final argument = this.argument as String;
    return searchNotes(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchNotesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchNotesHash() => r'2bdedf7c36ed45f34963192f7beff8d48ab0f5a1';

/// Full-text note search. Returns an empty list for blank queries so the UI
/// can render an idle/empty state without hitting the network.

final class SearchNotesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Note>>, String> {
  SearchNotesFamily._()
    : super(
        retry: null,
        name: r'searchNotesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Full-text note search. Returns an empty list for blank queries so the UI
  /// can render an idle/empty state without hitting the network.

  SearchNotesProvider call(String query) =>
      SearchNotesProvider._(argument: query, from: this);

  @override
  String toString() => r'searchNotesProvider';
}
