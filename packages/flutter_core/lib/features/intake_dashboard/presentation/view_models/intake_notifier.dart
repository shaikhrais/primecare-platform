import '../../../../flutter_core.dart';
import '../../domain/repositories/intake_repository.dart';
import '../providers/providers.dart';

class IntakeNotifier extends Notifier<AsyncValue<IntakeDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<IntakeDashboardViewModel>> {
  @override
  AsyncValue<IntakeDashboardViewModel> build() {
    return AsyncValue.data(IntakeDashboardViewModel.empty());
  }

  IIntakeRepository get _repository => ref.watch(intakeRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<IntakeDashboardViewModel>(
      fetch: () => _repository.getIntakeData(),
      onSuccess: (IntakeDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(IntakeDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
