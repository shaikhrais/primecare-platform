// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_monitoring_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SystemMonitoringController)
final systemMonitoringControllerProvider =
    SystemMonitoringControllerProvider._();

final class SystemMonitoringControllerProvider
    extends
        $NotifierProvider<SystemMonitoringController, SystemMonitoringState> {
  SystemMonitoringControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'systemMonitoringControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$systemMonitoringControllerHash();

  @$internal
  @override
  SystemMonitoringController create() => SystemMonitoringController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SystemMonitoringState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SystemMonitoringState>(value),
    );
  }
}

String _$systemMonitoringControllerHash() =>
    r'e1aa90754d22bc246d7fa933a1d7e3b4387b3b2d';

abstract class _$SystemMonitoringController
    extends $Notifier<SystemMonitoringState> {
  SystemMonitoringState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SystemMonitoringState, SystemMonitoringState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SystemMonitoringState, SystemMonitoringState>,
              SystemMonitoringState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
