import '../../../../flutter_core.dart';
import '../providers/providers.dart';

class AdminNotifier extends Notifier<AsyncValue<AdminDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<AdminDashboardViewModel>> {
  @override
  AsyncValue<AdminDashboardViewModel> build() {
    return AsyncValue.data(AdminDashboardViewModel.empty());
  }

  Future<void> loadData() async {
    await guardHydration<AdminDashboardViewModel>(
      fetch: () => ref.read(adminRepositoryProvider).getDashboardMetrics(),
      loadingState: const AsyncValue.loading(),
      onSuccess: (AdminDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(AdminDashboardViewModel.empty());
      },
    );
  }
}
