// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../providers/03_D_providers.dart';

class ClientNotifier extends Notifier<AsyncValue<ClientDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<ClientDashboardViewModel>> {
  @override
  AsyncValue<ClientDashboardViewModel> build() {
    return AsyncValue.data(ClientDashboardViewModel.empty());
  }

  Future<void> loadData() async {
    await guardHydration<ClientDashboardViewModel>(
      fetch: () => ref.read(clientRepositoryProvider).getDashboardMetrics(),
      loadingState: const AsyncValue.loading(),
      onSuccess: (ClientDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(ClientDashboardViewModel.empty());
      },
    );
  }
}
