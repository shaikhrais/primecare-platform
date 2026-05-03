// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(proposalRepository)
final proposalRepositoryProvider = ProposalRepositoryProvider._();

final class ProposalRepositoryProvider
    extends
        $FunctionalProvider<
          ProposalRepository,
          ProposalRepository,
          ProposalRepository
        >
    with $Provider<ProposalRepository> {
  ProposalRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proposalRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proposalRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProposalRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProposalRepository create(Ref ref) {
    return proposalRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProposalRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProposalRepository>(value),
    );
  }
}

String _$proposalRepositoryHash() =>
    r'd3c9623a59f3b79e8eb7f7be7b4634b562df9dc1';

@ProviderFor(ProposalList)
final proposalListProvider = ProposalListProvider._();

final class ProposalListProvider
    extends $AsyncNotifierProvider<ProposalList, List<ProposalIntake>> {
  ProposalListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proposalListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proposalListHash();

  @$internal
  @override
  ProposalList create() => ProposalList();
}

String _$proposalListHash() => r'4aa56540e0d479cfa141381169f7d8112d1d372f';

abstract class _$ProposalList extends $AsyncNotifier<List<ProposalIntake>> {
  FutureOr<List<ProposalIntake>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ProposalIntake>>, List<ProposalIntake>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ProposalIntake>>,
                List<ProposalIntake>
              >,
              AsyncValue<List<ProposalIntake>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
