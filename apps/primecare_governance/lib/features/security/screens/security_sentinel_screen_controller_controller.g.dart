// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_sentinel_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SecuritySentinelScreenControllerController)
final securitySentinelScreenControllerControllerProvider =
    SecuritySentinelScreenControllerControllerProvider._();

final class SecuritySentinelScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          SecuritySentinelScreenControllerController,
          Map<String, dynamic>
        > {
  SecuritySentinelScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'securitySentinelScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$securitySentinelScreenControllerControllerHash();

  @$internal
  @override
  SecuritySentinelScreenControllerController create() =>
      SecuritySentinelScreenControllerController();
}

String _$securitySentinelScreenControllerControllerHash() =>
    r'dc353ab9fc405a0ef4dede025825430bb030009a';

abstract class _$SecuritySentinelScreenControllerController
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
