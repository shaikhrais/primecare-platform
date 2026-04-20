import '../../../../flutter_core.dart';
import '../../domain/repositories/training_director_repository.dart';
import '../providers/providers.dart';

class TrainingDirectorNotifier
    extends Notifier<AsyncValue<TrainingDirectorDashboardViewModel>>
    with
        ResilientNotifierMixin<AsyncValue<TrainingDirectorDashboardViewModel>> {
  @override
  AsyncValue<TrainingDirectorDashboardViewModel> build() {
    return AsyncValue.data(TrainingDirectorDashboardViewModel.empty());
  }

  ITrainingDirectorRepository get _repository =>
      ref.watch(trainingDirectorRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<TrainingDirectorDashboardViewModel>(
      fetch: () => _repository.getTrainingDirectorData(),
      onSuccess: (TrainingDirectorDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(TrainingDirectorDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
