// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unknown_dashboard_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UnknownDashboardScreenControllerController)
final unknownDashboardScreenControllerControllerProvider =
    UnknownDashboardScreenControllerControllerProvider._();

final class UnknownDashboardScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          UnknownDashboardScreenControllerController,
          Map<String, dynamic>
        > {
  UnknownDashboardScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unknownDashboardScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$unknownDashboardScreenControllerControllerHash();

  @$internal
  @override
  UnknownDashboardScreenControllerController create() =>
      UnknownDashboardScreenControllerController();
}

String _$unknownDashboardScreenControllerControllerHash() =>
    r'b5f8774bf3cebf412271d95f8f1da3bb18a28fde';

abstract class _$UnknownDashboardScreenControllerController
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
