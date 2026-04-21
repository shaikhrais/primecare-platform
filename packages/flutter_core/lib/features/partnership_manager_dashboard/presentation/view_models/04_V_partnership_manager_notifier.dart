// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_partnership_manager_repository.dart';
import '../providers/03_D_providers.dart';

class PartnershipManagerNotifier
    extends Notifier<AsyncValue<PartnershipManagerDashboardViewModel>>
    with
        ResilientNotifierMixin<
          AsyncValue<PartnershipManagerDashboardViewModel>
        > {
  @override
  AsyncValue<PartnershipManagerDashboardViewModel> build() {
    return AsyncValue.data(PartnershipManagerDashboardViewModel.empty());
  }

  IPartnershipManagerRepository get _repository =>
      ref.watch(partnershipManagerRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<PartnershipManagerDashboardViewModel>(
      fetch: () => _repository.getPartnershipManagerData(),
      onSuccess: (PartnershipManagerDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(PartnershipManagerDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
