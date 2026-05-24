// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_reference_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ClinicalReferenceScreenControllerController)
final clinicalReferenceScreenControllerControllerProvider =
    ClinicalReferenceScreenControllerControllerProvider._();

final class ClinicalReferenceScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          ClinicalReferenceScreenControllerController,
          Map<String, dynamic>
        > {
  ClinicalReferenceScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clinicalReferenceScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$clinicalReferenceScreenControllerControllerHash();

  @$internal
  @override
  ClinicalReferenceScreenControllerController create() =>
      ClinicalReferenceScreenControllerController();
}

String _$clinicalReferenceScreenControllerControllerHash() =>
    r'c7c9f46e7a897b942f0fd207a691d15527b9e78f';

abstract class _$ClinicalReferenceScreenControllerController
    extends $AsyncNotifier<Map<String, dynamic>> {
  FutureOr<Map<String, dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<Map<String, dynamic>>, Map<String, dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, dynamic>>,
                Map<String, dynamic>
              >,
              AsyncValue<Map<String, dynamic>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
