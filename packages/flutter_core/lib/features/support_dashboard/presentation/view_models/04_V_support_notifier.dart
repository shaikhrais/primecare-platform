// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../providers/03_D_providers.dart';

class SupportNotifier extends Notifier<AsyncValue<SupportDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<SupportDashboardViewModel>> {
  @override
  AsyncValue<SupportDashboardViewModel> build() {
    return AsyncValue.data(SupportDashboardViewModel.empty());
  }

  Future<void> loadData() async {
    await guardHydration<SupportDashboardViewModel>(
      fetch: () => ref.read(supportRepositoryProvider).getDashboardMetrics(),
      loadingState: const AsyncValue.loading(),
      onSuccess: (SupportDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(SupportDashboardViewModel.empty());
      },
    );
  }
}
