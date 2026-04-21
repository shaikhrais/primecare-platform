// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../providers/03_D_providers.dart';

class ClinicNotifier extends Notifier<AsyncValue<ClinicDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<ClinicDashboardViewModel>> {
  @override
  AsyncValue<ClinicDashboardViewModel> build() {
    return AsyncValue.data(ClinicDashboardViewModel.empty());
  }

  Future<void> loadData() async {
    await guardHydration<ClinicDashboardViewModel>(
      fetch: () => ref.read(clinicRepositoryProvider).getDashboardMetrics(),
      loadingState: const AsyncValue.loading(),
      onSuccess: (ClinicDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(ClinicDashboardViewModel.empty());
      },
    );
  }
}
