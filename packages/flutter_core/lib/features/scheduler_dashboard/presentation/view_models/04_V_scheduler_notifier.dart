// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_scheduler_repository.dart';
import '../providers/03_D_providers.dart';

class SchedulerNotifier
    extends Notifier<AsyncValue<SchedulerDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<SchedulerDashboardViewModel>> {
  @override
  AsyncValue<SchedulerDashboardViewModel> build() {
    return AsyncValue.data(SchedulerDashboardViewModel.empty());
  }

  ISchedulerRepository get _repository =>
      ref.watch(schedulerRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<SchedulerDashboardViewModel>(
      fetch: () => _repository.getSchedulerData(),
      onSuccess: (SchedulerDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(SchedulerDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
