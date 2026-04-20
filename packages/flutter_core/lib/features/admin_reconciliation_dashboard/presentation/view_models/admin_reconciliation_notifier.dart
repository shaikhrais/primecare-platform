import '../../../../flutter_core.dart';
import '../providers/providers.dart';

class AdminReconciliationNotifier
    extends Notifier<AsyncValue<AdminReconciliationDashboardViewModel>>
    with
        ResilientNotifierMixin<
          AsyncValue<AdminReconciliationDashboardViewModel>
        > {
  @override
  AsyncValue<AdminReconciliationDashboardViewModel> build() {
    return AsyncValue.data(AdminReconciliationDashboardViewModel.empty());
  }

  Future<void> loadData() async {
    await guardHydration<AdminReconciliationDashboardViewModel>(
      fetch: () =>
          ref.read(adminReconciliationRepositoryProvider).getDashboardMetrics(),
      onSuccess: (data) => AsyncValue.data(data),
      onError: (message) => AsyncValue.error(message, StackTrace.current),
      loadingState: const AsyncValue.loading(),
    );
  }
}
