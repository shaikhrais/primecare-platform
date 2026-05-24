// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quality_metrics_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(QualityMetricsScreenControllerController)
final qualityMetricsScreenControllerControllerProvider =
    QualityMetricsScreenControllerControllerProvider._();

final class QualityMetricsScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          QualityMetricsScreenControllerController,
          Map<String, dynamic>
        > {
  QualityMetricsScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'qualityMetricsScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$qualityMetricsScreenControllerControllerHash();

  @$internal
  @override
  QualityMetricsScreenControllerController create() =>
      QualityMetricsScreenControllerController();
}

String _$qualityMetricsScreenControllerControllerHash() =>
    r'38829187675cd944f7c101fdd8704064664f940d';

abstract class _$QualityMetricsScreenControllerController
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
