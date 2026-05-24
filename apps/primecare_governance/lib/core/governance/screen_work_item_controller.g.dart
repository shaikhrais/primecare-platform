// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_work_item_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScreenWorkItemController)
final screenWorkItemControllerProvider = ScreenWorkItemControllerProvider._();

final class ScreenWorkItemControllerProvider
    extends
        $AsyncNotifierProvider<ScreenWorkItemController, Map<String, dynamic>> {
  ScreenWorkItemControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenWorkItemControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$screenWorkItemControllerHash();

  @$internal
  @override
  ScreenWorkItemController create() => ScreenWorkItemController();
}

String _$screenWorkItemControllerHash() =>
    r'45046bb9fca9ba2491ade4be51afe966b38e8972';

abstract class _$ScreenWorkItemController
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
