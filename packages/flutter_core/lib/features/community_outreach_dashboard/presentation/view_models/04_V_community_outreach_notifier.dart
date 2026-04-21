// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_community_outreach_repository.dart';
import '../providers/03_D_providers.dart';

class CommunityOutreachNotifier
    extends Notifier<AsyncValue<CommunityOutreachDashboardViewModel>>
    with
        ResilientNotifierMixin<
          AsyncValue<CommunityOutreachDashboardViewModel>
        > {
  @override
  AsyncValue<CommunityOutreachDashboardViewModel> build() {
    return AsyncValue.data(CommunityOutreachDashboardViewModel.empty());
  }

  ICommunityOutreachRepository get _repository =>
      ref.watch(communityOutreachRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<CommunityOutreachDashboardViewModel>(
      fetch: () => _repository.getCommunityOutreachData(),
      onSuccess: (CommunityOutreachDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(CommunityOutreachDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
