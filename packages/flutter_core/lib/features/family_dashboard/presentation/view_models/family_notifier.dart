import '../../../../flutter_core.dart';
import '../providers/providers.dart';

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
