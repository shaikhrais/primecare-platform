import '../../../../flutter_core.dart';
import '../providers/providers.dart';

class CeoNotifier extends Notifier<AsyncValue<CeoDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<CeoDashboardViewModel>> {
  @override
  AsyncValue<CeoDashboardViewModel> build() {
    return AsyncValue.data(CeoDashboardViewModel.empty());
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<CeoDashboardViewModel>(
      fetch: () => ref.read(ceoRepositoryProvider).getCeoData(),
      onSuccess: (CeoDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(CeoDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
