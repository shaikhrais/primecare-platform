import '../../../../flutter_core.dart';
import '../../domain/repositories/franchise_sales_manager_repository.dart';
import '../providers/providers.dart';

class FranchiseSalesManagerNotifier
    extends Notifier<AsyncValue<FranchiseSalesManagerDashboardViewModel>>
    with
        ResilientNotifierMixin<
          AsyncValue<FranchiseSalesManagerDashboardViewModel>
        > {
  @override
  AsyncValue<FranchiseSalesManagerDashboardViewModel> build() {
    return AsyncValue.data(FranchiseSalesManagerDashboardViewModel.empty());
  }

  IFranchiseSalesManagerRepository get _repository =>
      ref.watch(franchiseSalesManagerRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<FranchiseSalesManagerDashboardViewModel>(
      fetch: () => _repository.getFranchiseSalesManagerData(),
      onSuccess: (FranchiseSalesManagerDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(FranchiseSalesManagerDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
