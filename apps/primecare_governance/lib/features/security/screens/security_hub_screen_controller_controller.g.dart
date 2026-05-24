// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_hub_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SecurityHubScreenControllerController)
final securityHubScreenControllerControllerProvider =
    SecurityHubScreenControllerControllerProvider._();

final class SecurityHubScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          SecurityHubScreenControllerController,
          Map<String, dynamic>
        > {
  SecurityHubScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'securityHubScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$securityHubScreenControllerControllerHash();

  @$internal
  @override
  SecurityHubScreenControllerController create() =>
      SecurityHubScreenControllerController();
}

String _$securityHubScreenControllerControllerHash() =>
    r'ba59e9363521233867e7d1cef4efc385c7572554';

abstract class _$SecurityHubScreenControllerController
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
