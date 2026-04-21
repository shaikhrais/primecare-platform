// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_franchise_refunds_repository.dart';
import '../providers/03_D_providers.dart';

class FranchiseRefundsNotifier
    extends Notifier<AsyncValue<FranchiseRefundsDashboardViewModel>>
    with
        ResilientNotifierMixin<AsyncValue<FranchiseRefundsDashboardViewModel>> {
  @override
  AsyncValue<FranchiseRefundsDashboardViewModel> build() {
    return AsyncValue.data(FranchiseRefundsDashboardViewModel.empty());
  }

  IFranchiseRefundsRepository get _repository =>
      ref.watch(franchiseRefundsRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<FranchiseRefundsDashboardViewModel>(
      fetch: () => _repository.getDashboardMetrics(),
      onSuccess: (FranchiseRefundsDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(FranchiseRefundsDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
