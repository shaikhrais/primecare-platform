import '../../../../flutter_core.dart';
import '../../domain/repositories/cfo_repository.dart';
import '../providers/providers.dart';

class CfoNotifier extends Notifier<AsyncValue<CfoDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<CfoDashboardViewModel>> {
  @override
  AsyncValue<CfoDashboardViewModel> build() {
    return AsyncValue.data(CfoDashboardViewModel.empty());
  }

  ICfoRepository get _repository => ref.watch(cfoRepositoryProvider);

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
