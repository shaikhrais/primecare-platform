// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_cto_repository.dart';
import '../providers/03_D_providers.dart';

class CtoNotifier extends Notifier<AsyncValue<CtoDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<CtoDashboardViewModel>> {
  @override
  AsyncValue<CtoDashboardViewModel> build() {
    return AsyncValue.data(CtoDashboardViewModel.empty());
  }

  ICtoRepository get _repository => ref.watch(ctoRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<CtoDashboardViewModel>(
      fetch: () => _repository.getCtoData(),
      onSuccess: (CtoDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(CtoDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
