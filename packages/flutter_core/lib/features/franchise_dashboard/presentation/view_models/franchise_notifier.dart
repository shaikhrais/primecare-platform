import '../../../../flutter_core.dart';
import '../../domain/repositories/franchise_repository.dart';
import '../providers/providers.dart';

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
