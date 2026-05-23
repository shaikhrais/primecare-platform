// Governance - Category: view | Purpose: GENERATED CODE - DO NOT MODIFY BY HAND RiverpodGenerator GENERATED CODE - DO NOT MODIFY BY HAND ignore_for_file: type...
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_term_highlighter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(clinicalArticleTitles)
final clinicalArticleTitlesProvider = ClinicalArticleTitlesProvider._();

final class ClinicalArticleTitlesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  ClinicalArticleTitlesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clinicalArticleTitlesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clinicalArticleTitlesHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return clinicalArticleTitles(ref);
  }
}

String _$clinicalArticleTitlesHash() =>
    r'c7f8e62b56c58bd367ec1f41b6019e5ed2e62589';
