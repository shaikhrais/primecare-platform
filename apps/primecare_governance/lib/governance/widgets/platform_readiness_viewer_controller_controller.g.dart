// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_readiness_viewer_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PlatformReadinessViewerControllerController)
final platformReadinessViewerControllerControllerProvider =
    PlatformReadinessViewerControllerControllerProvider._();

final class PlatformReadinessViewerControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          PlatformReadinessViewerControllerController,
          Map<String, dynamic>
        > {
  PlatformReadinessViewerControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'platformReadinessViewerControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$platformReadinessViewerControllerControllerHash();

  @$internal
  @override
  PlatformReadinessViewerControllerController create() =>
      PlatformReadinessViewerControllerController();
}

String _$platformReadinessViewerControllerControllerHash() =>
    r'49f9355187b3660916e80704d6ba6c727165340f';

abstract class _$PlatformReadinessViewerControllerController
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
