// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regional_performance_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RegionalPerformanceScreenControllerController)
final regionalPerformanceScreenControllerControllerProvider =
    RegionalPerformanceScreenControllerControllerProvider._();

final class RegionalPerformanceScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          RegionalPerformanceScreenControllerController,
          Map<String, dynamic>
        > {
  RegionalPerformanceScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'regionalPerformanceScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$regionalPerformanceScreenControllerControllerHash();

  @$internal
  @override
  RegionalPerformanceScreenControllerController create() =>
      RegionalPerformanceScreenControllerController();
}

String _$regionalPerformanceScreenControllerControllerHash() =>
    r'8c0de0e3abeeb326325acd343e8b600ca5a8e0c8';

abstract class _$RegionalPerformanceScreenControllerController
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
