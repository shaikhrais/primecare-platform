import '../../../../flutter_core.dart';
import '../../domain/repositories/training_coordinator_repository.dart';
import '../providers/providers.dart';

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
