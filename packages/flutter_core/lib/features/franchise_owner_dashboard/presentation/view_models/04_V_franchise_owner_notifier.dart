// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../providers/03_D_providers.dart';

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
