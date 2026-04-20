import '../../../../flutter_core.dart';
import '../providers/providers.dart';

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
