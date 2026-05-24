// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'governance_hud_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GovernanceHudScreenControllerController)
final governanceHudScreenControllerControllerProvider =
    GovernanceHudScreenControllerControllerProvider._();

final class GovernanceHudScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          GovernanceHudScreenControllerController,
          Map<String, dynamic>
        > {
  GovernanceHudScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'governanceHudScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$governanceHudScreenControllerControllerHash();

  @$internal
  @override
  GovernanceHudScreenControllerController create() =>
      GovernanceHudScreenControllerController();
}

String _$governanceHudScreenControllerControllerHash() =>
    r'3bfc147776b2732e5532af45691611c5be75b4b1';

abstract class _$GovernanceHudScreenControllerController
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
