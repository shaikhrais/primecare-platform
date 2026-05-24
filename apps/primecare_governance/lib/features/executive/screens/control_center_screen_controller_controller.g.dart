// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'control_center_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ControlCenterScreenControllerController)
final controlCenterScreenControllerControllerProvider =
    ControlCenterScreenControllerControllerProvider._();

final class ControlCenterScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          ControlCenterScreenControllerController,
          Map<String, dynamic>
        > {
  ControlCenterScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'controlCenterScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$controlCenterScreenControllerControllerHash();

  @$internal
  @override
  ControlCenterScreenControllerController create() =>
      ControlCenterScreenControllerController();
}

String _$controlCenterScreenControllerControllerHash() =>
    r'1321d5d95a1accd030a46844d8a0912211598fa6';

abstract class _$ControlCenterScreenControllerController
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
