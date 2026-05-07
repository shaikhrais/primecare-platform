// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_education_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(clinicalEducationRepository)
final clinicalEducationRepositoryProvider =
    ClinicalEducationRepositoryProvider._();

final class ClinicalEducationRepositoryProvider
    extends
        $FunctionalProvider<
          ClinicalEducationRepository,
          ClinicalEducationRepository,
          ClinicalEducationRepository
        >
    with $Provider<ClinicalEducationRepository> {
  ClinicalEducationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clinicalEducationRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clinicalEducationRepositoryHash();

  @$internal
  @override
  $ProviderElement<ClinicalEducationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ClinicalEducationRepository create(Ref ref) {
    return clinicalEducationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClinicalEducationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClinicalEducationRepository>(value),
    );
  }
}

String _$clinicalEducationRepositoryHash() =>
    r'e1ce90027f1a502b9b7b0c93c4bb673360c8b978';

@ProviderFor(clinicalArticlesSearch)
final clinicalArticlesSearchProvider = ClinicalArticlesSearchFamily._();

final class ClinicalArticlesSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ClinicalArticle>>,
          List<ClinicalArticle>,
          FutureOr<List<ClinicalArticle>>
        >
    with
        $FutureModifier<List<ClinicalArticle>>,
        $FutureProvider<List<ClinicalArticle>> {
  ClinicalArticlesSearchProvider._({
    required ClinicalArticlesSearchFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'clinicalArticlesSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$clinicalArticlesSearchHash();

  @override
  String toString() {
    return r'clinicalArticlesSearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ClinicalArticle>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ClinicalArticle>> create(Ref ref) {
    final argument = this.argument as String;
    return clinicalArticlesSearch(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ClinicalArticlesSearchProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$clinicalArticlesSearchHash() =>
    r'a0196c927efabf905b2f929734ca75a57d0bb6a0';

final class ClinicalArticlesSearchFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ClinicalArticle>>, String> {
  ClinicalArticlesSearchFamily._()
    : super(
        retry: null,
        name: r'clinicalArticlesSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ClinicalArticlesSearchProvider call(String query) =>
      ClinicalArticlesSearchProvider._(argument: query, from: this);

  @override
  String toString() => r'clinicalArticlesSearchProvider';
}
