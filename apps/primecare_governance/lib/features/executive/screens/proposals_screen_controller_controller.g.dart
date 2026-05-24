// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposals_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProposalsScreenControllerController)
final proposalsScreenControllerControllerProvider =
    ProposalsScreenControllerControllerProvider._();

final class ProposalsScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          ProposalsScreenControllerController,
          Map<String, dynamic>
        > {
  ProposalsScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proposalsScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$proposalsScreenControllerControllerHash();

  @$internal
  @override
  ProposalsScreenControllerController create() =>
      ProposalsScreenControllerController();
}

String _$proposalsScreenControllerControllerHash() =>
    r'f4db6f7dee71470af7783af64cd3aef4dc4a1eba';

abstract class _$ProposalsScreenControllerController
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
