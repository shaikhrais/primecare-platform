// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'governance_role_viewer_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GovernanceRoleViewerControllerController)
final governanceRoleViewerControllerControllerProvider =
    GovernanceRoleViewerControllerControllerProvider._();

final class GovernanceRoleViewerControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          GovernanceRoleViewerControllerController,
          Map<String, dynamic>
        > {
  GovernanceRoleViewerControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'governanceRoleViewerControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$governanceRoleViewerControllerControllerHash();

  @$internal
  @override
  GovernanceRoleViewerControllerController create() =>
      GovernanceRoleViewerControllerController();
}

String _$governanceRoleViewerControllerControllerHash() =>
    r'f8c57c5fb8f406bcf57707175afaf79cf4a5c339';

abstract class _$GovernanceRoleViewerControllerController
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
