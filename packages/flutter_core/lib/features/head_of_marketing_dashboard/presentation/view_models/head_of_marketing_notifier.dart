import '../../../../flutter_core.dart';
import '../../domain/repositories/head_of_marketing_repository.dart';
import '../providers/providers.dart';

class HeadOfMarketingNotifier
    extends Notifier<AsyncValue<HeadOfMarketingDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<HeadOfMarketingDashboardViewModel>> {
  @override
  AsyncValue<HeadOfMarketingDashboardViewModel> build() {
    return AsyncValue.data(HeadOfMarketingDashboardViewModel.empty());
  }

  IHeadOfMarketingRepository get _repository =>
      ref.watch(headOfMarketingRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<HeadOfMarketingDashboardViewModel>(
      fetch: () => _repository.getHeadOfMarketingData(),
      onSuccess: (HeadOfMarketingDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(HeadOfMarketingDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
