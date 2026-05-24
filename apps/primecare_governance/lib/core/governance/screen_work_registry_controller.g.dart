// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_work_registry_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScreenWorkRegistryController)
final screenWorkRegistryControllerProvider =
    ScreenWorkRegistryControllerProvider._();

final class ScreenWorkRegistryControllerProvider
    extends
        $AsyncNotifierProvider<
          ScreenWorkRegistryController,
          Map<String, dynamic>
        > {
  ScreenWorkRegistryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenWorkRegistryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$screenWorkRegistryControllerHash();

  @$internal
  @override
  ScreenWorkRegistryController create() => ScreenWorkRegistryController();
}

String _$screenWorkRegistryControllerHash() =>
    r'66469c356d018d6547909bda4cf459f88bb4bd45';

abstract class _$ScreenWorkRegistryController
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
