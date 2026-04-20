import '../../../../flutter_core.dart';
import '../../domain/repositories/cto_repository.dart';
import '../providers/providers.dart';

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
