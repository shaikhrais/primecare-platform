// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_center_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VerificationCenterScreenControllerController)
final verificationCenterScreenControllerControllerProvider =
    VerificationCenterScreenControllerControllerProvider._();

final class VerificationCenterScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          VerificationCenterScreenControllerController,
          Map<String, dynamic>
        > {
  VerificationCenterScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verificationCenterScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$verificationCenterScreenControllerControllerHash();

  @$internal
  @override
  VerificationCenterScreenControllerController create() =>
      VerificationCenterScreenControllerController();
}

String _$verificationCenterScreenControllerControllerHash() =>
    r'a356b1bdabc60582939dd4bc070b99d39ee3f142';

abstract class _$VerificationCenterScreenControllerController
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
