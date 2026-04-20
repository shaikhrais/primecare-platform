import '../../../../flutter_core.dart';
import '../../domain/repositories/operations_manager_repository.dart';
import '../providers/providers.dart';

class OperationsManagerNotifier
    extends Notifier<AsyncValue<OperationsManagerDashboardViewModel>>
    with
        ResilientNotifierMixin<
          AsyncValue<OperationsManagerDashboardViewModel>
        > {
  @override
  AsyncValue<OperationsManagerDashboardViewModel> build() {
    return AsyncValue.data(OperationsManagerDashboardViewModel.empty());
  }

  IOperationsManagerRepository get _repository =>
      ref.watch(operationsManagerRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<OperationsManagerDashboardViewModel>(
      fetch: () => _repository.getOperationsManagerData(),
      onSuccess: (OperationsManagerDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(OperationsManagerDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
