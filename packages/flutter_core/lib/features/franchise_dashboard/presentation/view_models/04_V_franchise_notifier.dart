// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_franchise_repository.dart';
import '../providers/03_D_providers.dart';

class FranchiseNotifier
    extends Notifier<AsyncValue<FranchiseDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<FranchiseDashboardViewModel>> {
  @override
  AsyncValue<FranchiseDashboardViewModel> build() {
    return AsyncValue.data(FranchiseDashboardViewModel.empty());
  }

  IFranchiseRepository get _repository =>
      ref.watch(franchiseRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<FranchiseDashboardViewModel>(
      fetch: () => _repository.getDashboardMetrics(),
      onSuccess: (FranchiseDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(FranchiseDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
    );
  }
}
