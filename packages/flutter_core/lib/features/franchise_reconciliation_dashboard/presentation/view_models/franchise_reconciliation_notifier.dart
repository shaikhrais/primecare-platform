import '../../../../flutter_core.dart';
import '../../domain/repositories/franchise_reconciliation_repository.dart';
import '../providers/providers.dart';

class FranchiseReconciliationNotifier
    extends Notifier<AsyncValue<FranchiseReconciliationDashboardViewModel>>
    with
        ResilientNotifierMixin<
          AsyncValue<FranchiseReconciliationDashboardViewModel>
        > {
  @override
  AsyncValue<FranchiseReconciliationDashboardViewModel> build() {
    return AsyncValue.data(FranchiseReconciliationDashboardViewModel.empty());
  }

  IFranchiseReconciliationRepository get _repository =>
      ref.watch(franchiseReconciliationRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<FranchiseReconciliationDashboardViewModel>(
      fetch: () => _repository.getFranchiseReconciliationData(),
      onSuccess: (FranchiseReconciliationDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(
          FranchiseReconciliationDashboardViewModel.empty(),
        );
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
