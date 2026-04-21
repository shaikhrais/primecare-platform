// Layer: 04_VIEW_MODELS
import '../../../../00_B_flutter_core.dart';
import '../../domain/repositories/03_D_compliance_manager_repository.dart';
import '../providers/03_D_providers.dart';

class ComplianceManagerNotifier
    extends Notifier<AsyncValue<ComplianceManagerDashboardViewModel>>
    with
        ResilientNotifierMixin<
          AsyncValue<ComplianceManagerDashboardViewModel>
        > {
  @override
  AsyncValue<ComplianceManagerDashboardViewModel> build() {
    return AsyncValue.data(ComplianceManagerDashboardViewModel.empty());
  }

  IComplianceManagerRepository get _repository =>
      ref.watch(complianceManagerRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<ComplianceManagerDashboardViewModel>(
      fetch: () => _repository.getComplianceManagerData(),
      onSuccess: (ComplianceManagerDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(ComplianceManagerDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
