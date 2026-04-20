import '../../../../flutter_core.dart';
import '../../domain/repositories/regional_manager_ontario_repository.dart';
import '../providers/providers.dart';

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
