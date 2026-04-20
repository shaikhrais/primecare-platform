import '../../../../flutter_core.dart';
import '../../domain/repositories/customer_support_repository.dart';
import '../providers/providers.dart';

class CustomerSupportNotifier
    extends Notifier<AsyncValue<CustomerSupportDashboardViewModel>>
    with ResilientNotifierMixin<AsyncValue<CustomerSupportDashboardViewModel>> {
  @override
  AsyncValue<CustomerSupportDashboardViewModel> build() {
    return AsyncValue.data(CustomerSupportDashboardViewModel.empty());
  }

  ICustomerSupportRepository get _repository =>
      ref.watch(customerSupportRepositoryProvider);

  Future<void> loadData() async {
    state = const AsyncValue.loading();

    await guardHydration<CustomerSupportDashboardViewModel>(
      fetch: () => _repository.getCustomerSupportData(),
      onSuccess: (CustomerSupportDashboardViewModel data) {
        return AsyncValue.data(data);
      },
      onError: (String message) {
        return AsyncValue.data(CustomerSupportDashboardViewModel.empty());
      },
      loadingState: const AsyncValue.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
