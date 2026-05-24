// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compliance_reviews_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ComplianceReviewsScreenControllerController)
final complianceReviewsScreenControllerControllerProvider =
    ComplianceReviewsScreenControllerControllerProvider._();

final class ComplianceReviewsScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          ComplianceReviewsScreenControllerController,
          Map<String, dynamic>
        > {
  ComplianceReviewsScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'complianceReviewsScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$complianceReviewsScreenControllerControllerHash();

  @$internal
  @override
  ComplianceReviewsScreenControllerController create() =>
      ComplianceReviewsScreenControllerController();
}

String _$complianceReviewsScreenControllerControllerHash() =>
    r'c5bb7716ba8fd88afe2d1f1fb84191d8deee2d21';

abstract class _$ComplianceReviewsScreenControllerController
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
