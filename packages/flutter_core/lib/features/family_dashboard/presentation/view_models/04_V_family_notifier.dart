// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../providers/03_D_providers.dart';

class FamilyNotifier extends Notifier<AsyncValue<FamilyDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<FamilyDashboardViewModel>> {
  @override
  AsyncValue<FamilyDashboardViewModel> build() {
    return AsyncValue.data(FamilyDashboardViewModel.empty());
  }

  Future<void> loadData() async {
    await guardHydration<FamilyDashboardViewModel>(
      fetch: () => ref.read(familyRepositoryProvider).getDashboardMetrics(),
      loadingState: const AsyncValue.loading(),
      onSuccess: (FamilyDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(FamilyDashboardViewModel.empty());
      },
    );
  }
}
