import '../../../../flutter_core.dart';
import '../../domain/repositories/billing_admin_repository.dart';
import '../providers/providers.dart';

class BillingAdminNotifier
    extends Notifier<AsyncValue<BillingAdminDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<BillingAdminDashboardViewModel>> {
  @override
  AsyncValue<BillingAdminDashboardViewModel> build() {
    return AsyncValue.data(BillingAdminDashboardViewModel.empty());
  }

  IBillingAdminRepository get _repository =>
      ref.watch(billingAdminRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<BillingAdminDashboardViewModel>(
      fetch: () => _repository.getBillingAdminData(),
      onSuccess: (BillingAdminDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(BillingAdminDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
