// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_scrum_master_repository.dart';
import '../providers/03_D_providers.dart';

class ScrumMasterNotifier
    extends Notifier<AsyncValue<ScrumMasterDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<ScrumMasterDashboardViewModel>> {
  @override
  AsyncValue<ScrumMasterDashboardViewModel> build() {
    return AsyncValue.data(ScrumMasterDashboardViewModel.empty());
  }

  IScrumMasterRepository get _repository =>
      ref.watch(scrumMasterRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<ScrumMasterDashboardViewModel>(
      fetch: () => _repository.getScrumMasterData(),
      onSuccess: (ScrumMasterDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(ScrumMasterDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
