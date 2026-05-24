// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident_reports_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IncidentReportsScreenControllerController)
final incidentReportsScreenControllerControllerProvider =
    IncidentReportsScreenControllerControllerProvider._();

final class IncidentReportsScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          IncidentReportsScreenControllerController,
          Map<String, dynamic>
        > {
  IncidentReportsScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incidentReportsScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$incidentReportsScreenControllerControllerHash();

  @$internal
  @override
  IncidentReportsScreenControllerController create() =>
      IncidentReportsScreenControllerController();
}

String _$incidentReportsScreenControllerControllerHash() =>
    r'88c1078936f43a037dfb992fac3e1399a8a9c213';

abstract class _$IncidentReportsScreenControllerController
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
