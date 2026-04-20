import '../../../../flutter_core.dart';
import '../../domain/models/receptionist_dashboard_view_model.dart';
import '../../domain/repositories/receptionist_repository.dart';
import '../providers/providers.dart';

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
