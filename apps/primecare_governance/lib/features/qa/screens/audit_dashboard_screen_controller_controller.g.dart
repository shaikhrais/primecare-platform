// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_dashboard_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuditDashboardScreenControllerController)
final auditDashboardScreenControllerControllerProvider =
    AuditDashboardScreenControllerControllerProvider._();

final class AuditDashboardScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          AuditDashboardScreenControllerController,
          Map<String, dynamic>
        > {
  AuditDashboardScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'auditDashboardScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$auditDashboardScreenControllerControllerHash();

  @$internal
  @override
  AuditDashboardScreenControllerController create() =>
      AuditDashboardScreenControllerController();
}

String _$auditDashboardScreenControllerControllerHash() =>
    r'2a5f78a7acc908e5b197e535bc1571e0a26c6bf7';

abstract class _$AuditDashboardScreenControllerController
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
