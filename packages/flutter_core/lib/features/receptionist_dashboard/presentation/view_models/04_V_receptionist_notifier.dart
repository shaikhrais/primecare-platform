// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_receptionist_repository.dart';
import '../providers/03_D_providers.dart';

class ReceptionistNotifier
    extends Notifier<AsyncValue<ReceptionistDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<ReceptionistDashboardViewModel>> {
  @override
  AsyncValue<ReceptionistDashboardViewModel> build() {
    return AsyncValue.data(ReceptionistDashboardViewModel.empty());
  }

  IReceptionistRepository get _repository =>
      ref.watch(receptionistRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<ReceptionistDashboardViewModel>(
      fetch: () => _repository.getReceptionistData(),
      onSuccess: (ReceptionistDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(ReceptionistDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
