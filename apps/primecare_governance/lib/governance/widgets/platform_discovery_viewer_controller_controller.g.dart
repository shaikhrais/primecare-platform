// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform_discovery_viewer_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PlatformDiscoveryViewerControllerController)
final platformDiscoveryViewerControllerControllerProvider =
    PlatformDiscoveryViewerControllerControllerProvider._();

final class PlatformDiscoveryViewerControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          PlatformDiscoveryViewerControllerController,
          Map<String, dynamic>
        > {
  PlatformDiscoveryViewerControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'platformDiscoveryViewerControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$platformDiscoveryViewerControllerControllerHash();

  @$internal
  @override
  PlatformDiscoveryViewerControllerController create() =>
      PlatformDiscoveryViewerControllerController();
}

String _$platformDiscoveryViewerControllerControllerHash() =>
    r'e41a616b45fab207e4986b295328a548540f2a3f';

abstract class _$PlatformDiscoveryViewerControllerController
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
