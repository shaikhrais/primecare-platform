// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_coo_repository.dart';
import '../providers/03_D_providers.dart';

class CooNotifier extends Notifier<AsyncValue<CooDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<CooDashboardViewModel>> {
  @override
  AsyncValue<CooDashboardViewModel> build() {
    return AsyncValue.data(CooDashboardViewModel.empty());
  }

  ICooRepository get _repository => ref.watch(cooRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<CooDashboardViewModel>(
      fetch: () => _repository.getCooData(),
      onSuccess: (CooDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(CooDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
