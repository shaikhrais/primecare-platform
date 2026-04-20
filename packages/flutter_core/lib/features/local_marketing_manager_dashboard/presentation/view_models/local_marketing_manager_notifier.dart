import '../../../../flutter_core.dart';
import '../../domain/repositories/local_marketing_manager_repository.dart';
import '../providers/providers.dart';

class LocalMarketingManagerNotifier
    extends Notifier<AsyncValue<LocalMarketingManagerDashboardViewModel>>
    with
        ResilientNotifierMixin<
          AsyncValue<LocalMarketingManagerDashboardViewModel>
        > {
  @override
  AsyncValue<LocalMarketingManagerDashboardViewModel> build() {
    return AsyncValue.data(LocalMarketingManagerDashboardViewModel.empty());
  }

  ILocalMarketingManagerRepository get _repository =>
      ref.watch(localMarketingManagerRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<LocalMarketingManagerDashboardViewModel>(
      fetch: () => _repository.getLocalMarketingManagerData(),
      onSuccess: (LocalMarketingManagerDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(LocalMarketingManagerDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
