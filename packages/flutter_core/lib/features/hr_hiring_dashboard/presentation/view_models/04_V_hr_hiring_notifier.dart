// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_hr_hiring_repository.dart';
import '../providers/03_D_providers.dart';

class HrHiringNotifier extends Notifier<AsyncValue<HrHiringDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<HrHiringDashboardViewModel>> {
  @override
  AsyncValue<HrHiringDashboardViewModel> build() {
    return AsyncValue.data(HrHiringDashboardViewModel.empty());
  }

  IHrHiringRepository get _repository => ref.watch(hrHiringRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<HrHiringDashboardViewModel>(
      fetch: () => _repository.getHrHiringData(),
      onSuccess: (HrHiringDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(HrHiringDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
