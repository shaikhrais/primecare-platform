// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_status_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScreenStatusScreenControllerController)
final screenStatusScreenControllerControllerProvider =
    ScreenStatusScreenControllerControllerProvider._();

final class ScreenStatusScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          ScreenStatusScreenControllerController,
          Map<String, dynamic>
        > {
  ScreenStatusScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenStatusScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$screenStatusScreenControllerControllerHash();

  @$internal
  @override
  ScreenStatusScreenControllerController create() =>
      ScreenStatusScreenControllerController();
}

String _$screenStatusScreenControllerControllerHash() =>
    r'd7770429b90909571160b5f580fc8d239d2360d9';

abstract class _$ScreenStatusScreenControllerController
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
