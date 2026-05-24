// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leadership_reports_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LeadershipReportsScreenControllerController)
final leadershipReportsScreenControllerControllerProvider =
    LeadershipReportsScreenControllerControllerProvider._();

final class LeadershipReportsScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          LeadershipReportsScreenControllerController,
          Map<String, dynamic>
        > {
  LeadershipReportsScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'leadershipReportsScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$leadershipReportsScreenControllerControllerHash();

  @$internal
  @override
  LeadershipReportsScreenControllerController create() =>
      LeadershipReportsScreenControllerController();
}

String _$leadershipReportsScreenControllerControllerHash() =>
    r'48f5a5251224eb61b8491dd858395485e2b75f5d';

abstract class _$LeadershipReportsScreenControllerController
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
