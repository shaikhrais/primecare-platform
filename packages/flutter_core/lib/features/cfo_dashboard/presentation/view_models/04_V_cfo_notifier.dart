// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_cfo_repository.dart';
import '../providers/03_D_providers.dart';

class CfoNotifier extends Notifier<AsyncValue<CfoDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<CfoDashboardViewModel>> {
  @override
  AsyncValue<CfoDashboardViewModel> build() {
    return AsyncValue.data(CfoDashboardViewModel.empty());
  }

  ICfoRepository get _repository =>
      ref.read<ICfoRepository>(cfoRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<CfoDashboardViewModel>(
      fetch: () => _repository.getCfoData(),
      onSuccess: (CfoDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(CfoDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
