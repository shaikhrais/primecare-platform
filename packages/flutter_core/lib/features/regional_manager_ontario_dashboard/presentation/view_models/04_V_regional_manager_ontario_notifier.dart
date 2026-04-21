// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_regional_manager_ontario_repository.dart';
import '../providers/03_D_providers.dart';

class RegionalManagerOntarioNotifier
    extends Notifier<AsyncValue<RegionalManagerOntarioDashboardViewModel>>
    with
        ResilientNotifierMixin<
          AsyncValue<RegionalManagerOntarioDashboardViewModel>
        > {
  @override
  AsyncValue<RegionalManagerOntarioDashboardViewModel> build() {
    return AsyncValue.data(RegionalManagerOntarioDashboardViewModel.empty());
  }

  IRegionalManagerOntarioRepository get _repository =>
      ref.watch(regionalManagerOntarioRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<RegionalManagerOntarioDashboardViewModel>(
      fetch: () => _repository.getRegionalManagerOntarioData(),
      onSuccess: (RegionalManagerOntarioDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(
          RegionalManagerOntarioDashboardViewModel.empty(),
        );
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
