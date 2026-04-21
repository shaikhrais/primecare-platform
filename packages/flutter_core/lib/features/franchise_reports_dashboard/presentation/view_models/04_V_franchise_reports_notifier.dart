// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_franchise_reports_repository.dart';
import '../providers/03_D_providers.dart';

class FranchiseReportsNotifier
    extends Notifier<AsyncValue<FranchiseReportsDashboardViewModel>>
    with
        ResilientNotifierMixin<AsyncValue<FranchiseReportsDashboardViewModel>> {
  @override
  AsyncValue<FranchiseReportsDashboardViewModel> build() {
    return AsyncValue.data(FranchiseReportsDashboardViewModel.empty());
  }

  IFranchiseReportsRepository get _repository =>
      ref.watch(franchiseReportsRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<FranchiseReportsDashboardViewModel>(
      fetch: () => _repository.getDashboardMetrics(),
      onSuccess: (FranchiseReportsDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(FranchiseReportsDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
