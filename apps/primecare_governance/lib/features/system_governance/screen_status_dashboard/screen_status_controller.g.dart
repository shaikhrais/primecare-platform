// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_status_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScreenStatusController)
final screenStatusControllerProvider = ScreenStatusControllerProvider._();

final class ScreenStatusControllerProvider
    extends $NotifierProvider<ScreenStatusController, ScreenStatusState> {
  ScreenStatusControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenStatusControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$screenStatusControllerHash();

  @$internal
  @override
  ScreenStatusController create() => ScreenStatusController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScreenStatusState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScreenStatusState>(value),
    );
  }
}

String _$screenStatusControllerHash() =>
    r'ca05b1deb21ad16c853881178f95bac345f922df';

abstract class _$ScreenStatusController extends $Notifier<ScreenStatusState> {
  ScreenStatusState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ScreenStatusState, ScreenStatusState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ScreenStatusState, ScreenStatusState>,
              ScreenStatusState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
