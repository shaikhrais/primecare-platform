// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuditLogScreenControllerController)
final auditLogScreenControllerControllerProvider =
    AuditLogScreenControllerControllerProvider._();

final class AuditLogScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          AuditLogScreenControllerController,
          Map<String, dynamic>
        > {
  AuditLogScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'auditLogScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$auditLogScreenControllerControllerHash();

  @$internal
  @override
  AuditLogScreenControllerController create() =>
      AuditLogScreenControllerController();
}

String _$auditLogScreenControllerControllerHash() =>
    r'298d38465a29f5901f053830e5abe2fd72b8e306';

abstract class _$AuditLogScreenControllerController
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
