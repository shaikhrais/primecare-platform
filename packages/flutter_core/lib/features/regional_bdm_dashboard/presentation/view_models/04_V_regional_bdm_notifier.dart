// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_regional_bdm_repository.dart';
import '../providers/03_D_providers.dart';

class RegionalBdmNotifier
    extends Notifier<AsyncValue<RegionalBdmDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<RegionalBdmDashboardViewModel>> {
  @override
  AsyncValue<RegionalBdmDashboardViewModel> build() {
    return AsyncValue.data(RegionalBdmDashboardViewModel.empty());
  }

  IRegionalBdmRepository get _repository =>
      ref.watch(regionalBdmRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<RegionalBdmDashboardViewModel>(
      fetch: () => _repository.getRegionalBdmData(),
      onSuccess: (RegionalBdmDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(RegionalBdmDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
