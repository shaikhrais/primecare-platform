import '../../../../flutter_core.dart';
import '../../domain/repositories/hr_hiring_repository.dart';
import '../providers/providers.dart';

class HrHiringNotifier extends Notifier<AsyncValue<HRHiringDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<HRHiringDashboardViewModel>> {
  @override
  AsyncValue<HRHiringDashboardViewModel> build() {
    return AsyncValue.data(HRHiringDashboardViewModel.empty());
  }

  IHrHiringRepository get _repository => ref.watch(hrHiringRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<HRHiringDashboardViewModel>(
      fetch: () => _repository.getHrHiringData(),
      onSuccess: (HRHiringDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(HRHiringDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
