// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_qa_repository.dart';
import '../providers/03_D_providers.dart';

class QaNotifier extends Notifier<AsyncValue<QaDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<QaDashboardViewModel>> {
  @override
  AsyncValue<QaDashboardViewModel> build() {
    return AsyncValue.data(QaDashboardViewModel.empty());
  }

  IQaRepository get _repository => ref.watch(qaRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<QaDashboardViewModel>(
      fetch: () => _repository.getQaData(),
      onSuccess: (QaDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(QaDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
