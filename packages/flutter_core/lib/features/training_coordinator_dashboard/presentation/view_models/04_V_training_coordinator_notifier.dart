// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_training_coordinator_repository.dart';
import '../providers/03_D_providers.dart';

class TrainingCoordinatorNotifier
    extends Notifier<AsyncValue<TrainingCoordinatorDashboardViewModel>>
    with
        ResilientNotifierMixin<
          AsyncValue<TrainingCoordinatorDashboardViewModel>
        > {
  @override
  AsyncValue<TrainingCoordinatorDashboardViewModel> build() {
    return AsyncValue.data(TrainingCoordinatorDashboardViewModel.empty());
  }

  ITrainingCoordinatorRepository get _repository =>
      ref.watch(trainingCoordinatorRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<TrainingCoordinatorDashboardViewModel>(
      fetch: () => _repository.getTrainingCoordinatorData(),
      onSuccess: (TrainingCoordinatorDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(TrainingCoordinatorDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
