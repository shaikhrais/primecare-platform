import '../../../../flutter_core.dart';
import '../providers/providers.dart';

class PatientNotifier extends Notifier<AsyncValue<PatientDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<PatientDashboardViewModel>> {
  @override
  AsyncValue<PatientDashboardViewModel> build() {
    return AsyncValue.data(PatientDashboardViewModel.empty());
  }

  Future<void> loadData() async {
    await guardHydration<PatientDashboardViewModel>(
      fetch: () => ref.read(patientRepositoryProvider).getDashboardMetrics(),
      loadingState: const AsyncValue.loading(),
      onSuccess: (PatientDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(PatientDashboardViewModel.empty());
      },
    );
  }
}
