import '../../../../flutter_core.dart';
import '../../domain/repositories/territory_expansion_manager_repository.dart';
import '../providers/providers.dart';

class TerritoryExpansionManagerNotifier
    extends Notifier<AsyncValue<TerritoryExpansionManagerDashboardViewModel>>
    with
        ResilientNotifierMixin<
          AsyncValue<TerritoryExpansionManagerDashboardViewModel>
        > {
  @override
  AsyncValue<TerritoryExpansionManagerDashboardViewModel> build() {
    return AsyncValue.data(TerritoryExpansionManagerDashboardViewModel.empty());
  }

  ITerritoryExpansionManagerRepository get _repository =>
      ref.watch(territoryExpansionManagerRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<TerritoryExpansionManagerDashboardViewModel>(
      fetch: () => _repository.getTerritoryExpansionManagerData(),
      onSuccess: (TerritoryExpansionManagerDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(
          TerritoryExpansionManagerDashboardViewModel.empty(),
        );
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
