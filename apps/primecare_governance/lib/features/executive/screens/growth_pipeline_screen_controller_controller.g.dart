// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'growth_pipeline_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GrowthPipelineScreenControllerController)
final growthPipelineScreenControllerControllerProvider =
    GrowthPipelineScreenControllerControllerProvider._();

final class GrowthPipelineScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          GrowthPipelineScreenControllerController,
          Map<String, dynamic>
        > {
  GrowthPipelineScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'growthPipelineScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$growthPipelineScreenControllerControllerHash();

  @$internal
  @override
  GrowthPipelineScreenControllerController create() =>
      GrowthPipelineScreenControllerController();
}

String _$growthPipelineScreenControllerControllerHash() =>
    r'a0f37fce85b9d389a6018f1d50f78fb1e13cc9fa';

abstract class _$GrowthPipelineScreenControllerController
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
