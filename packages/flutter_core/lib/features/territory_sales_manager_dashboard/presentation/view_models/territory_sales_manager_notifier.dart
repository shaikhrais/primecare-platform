import '../../../../flutter_core.dart';
import '../../domain/repositories/territory_sales_manager_repository.dart';
import '../providers/providers.dart';

class TerritorySalesManagerNotifier
    extends Notifier<AsyncValue<TerritorySalesManagerDashboardViewModel>>
    with
        ResilientNotifierMixin<
          AsyncValue<TerritorySalesManagerDashboardViewModel>
        > {
  @override
  AsyncValue<TerritorySalesManagerDashboardViewModel> build() {
    return AsyncValue.data(TerritorySalesManagerDashboardViewModel.empty());
  }

  ITerritorySalesManagerRepository get _repository =>
      ref.watch(territorySalesManagerRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<TerritorySalesManagerDashboardViewModel>(
      fetch: () => _repository.getTerritorySalesManagerData(),
      onSuccess: (TerritorySalesManagerDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(TerritorySalesManagerDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
