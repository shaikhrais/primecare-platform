// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../providers/03_D_providers.dart';

class CeoNotifier extends Notifier<AsyncValue<CeoDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<CeoDashboardViewModel>> {
  @override
  AsyncValue<CeoDashboardViewModel> build() {
    return AsyncValue.data(CeoDashboardViewModel.empty());
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<CeoDashboardViewModel>(
      fetch: () => ref.read<CeoRepository>(ceoRepositoryProvider).getCeoData(),
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
