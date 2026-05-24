// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitoring_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MonitoringScreenControllerController)
final monitoringScreenControllerControllerProvider =
    MonitoringScreenControllerControllerProvider._();

final class MonitoringScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          MonitoringScreenControllerController,
          Map<String, dynamic>
        > {
  MonitoringScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'monitoringScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$monitoringScreenControllerControllerHash();

  @$internal
  @override
  MonitoringScreenControllerController create() =>
      MonitoringScreenControllerController();
}

String _$monitoringScreenControllerControllerHash() =>
    r'8737aac7775b9b8c790c41b23237022feabea781';

abstract class _$MonitoringScreenControllerController
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
