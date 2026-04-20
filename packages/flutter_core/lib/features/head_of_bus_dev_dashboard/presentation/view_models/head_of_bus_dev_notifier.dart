import '../../../../flutter_core.dart';
import '../../domain/repositories/head_of_bus_dev_repository.dart';
import '../providers/providers.dart';

class HeadOfBusDevNotifier
    extends Notifier<AsyncValue<HeadOfBusDevDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<HeadOfBusDevDashboardViewModel>> {
  @override
  AsyncValue<HeadOfBusDevDashboardViewModel> build() {
    return AsyncValue.data(HeadOfBusDevDashboardViewModel.empty());
  }

  IHeadOfBusDevRepository get _repository =>
      ref.watch(headOfBusDevRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<HeadOfBusDevDashboardViewModel>(
      fetch: () => _repository.getHeadOfBusDevData(),
      onSuccess: (HeadOfBusDevDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(HeadOfBusDevDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
