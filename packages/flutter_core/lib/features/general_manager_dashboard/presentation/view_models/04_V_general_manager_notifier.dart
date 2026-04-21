// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_general_manager_repository.dart';
import '../providers/03_D_providers.dart';

class GeneralManagerNotifier
    extends Notifier<AsyncValue<GeneralManagerDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<GeneralManagerDashboardViewModel>> {
  @override
  AsyncValue<GeneralManagerDashboardViewModel> build() {
    return AsyncValue.data(GeneralManagerDashboardViewModel.empty());
  }

  IGeneralManagerRepository get _repository =>
      ref.watch(generalManagerRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<GeneralManagerDashboardViewModel>(
      fetch: () => _repository.getGeneralManagerData(),
      onSuccess: (GeneralManagerDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(GeneralManagerDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
