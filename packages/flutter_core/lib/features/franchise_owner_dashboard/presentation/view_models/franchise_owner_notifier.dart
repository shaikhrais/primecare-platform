import '../../../../flutter_core.dart';
import '../providers/providers.dart';

class FranchiseOwnerNotifier
    extends Notifier<AsyncValue<FranchiseOwnerDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<FranchiseOwnerDashboardViewModel>> {
  @override
  AsyncValue<FranchiseOwnerDashboardViewModel> build() {
    return AsyncValue.data(FranchiseOwnerDashboardViewModel.empty());
  }

  Future<void> loadData() async {
    await guardHydration<FranchiseOwnerDashboardViewModel>(
      fetch: () =>
          ref.read(franchiseOwnerRepositoryProvider).getDashboardMetrics(),
      loadingState: const AsyncValue.loading(),
      onSuccess: (FranchiseOwnerDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(FranchiseOwnerDashboardViewModel.empty());
      },
    );
  }
}
