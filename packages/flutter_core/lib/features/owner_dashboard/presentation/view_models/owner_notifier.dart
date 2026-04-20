import '../../../../flutter_core.dart';
import '../../domain/repositories/owner_repository.dart';
import '../providers/providers.dart';

class OwnerNotifier extends Notifier<AsyncValue<OwnerDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<OwnerDashboardViewModel>> {
  @override
  AsyncValue<OwnerDashboardViewModel> build() {
    return AsyncValue.data(OwnerDashboardViewModel.empty());
  }

  IOwnerRepository get _repository => ref.watch(ownerRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<OwnerDashboardViewModel>(
      fetch: () => _repository.getOwnerDashboard(),
      onSuccess: (OwnerDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(OwnerDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
    );
  }
}
