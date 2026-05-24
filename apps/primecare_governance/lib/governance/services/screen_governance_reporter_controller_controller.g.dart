// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_governance_reporter_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScreenGovernanceReporterControllerController)
final screenGovernanceReporterControllerControllerProvider =
    ScreenGovernanceReporterControllerControllerProvider._();

final class ScreenGovernanceReporterControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          ScreenGovernanceReporterControllerController,
          Map<String, dynamic>
        > {
  ScreenGovernanceReporterControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenGovernanceReporterControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$screenGovernanceReporterControllerControllerHash();

  @$internal
  @override
  ScreenGovernanceReporterControllerController create() =>
      ScreenGovernanceReporterControllerController();
}

String _$screenGovernanceReporterControllerControllerHash() =>
    r'a6b209fbded62191ebce204f801e1d4df9156f50';

abstract class _$ScreenGovernanceReporterControllerController
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
