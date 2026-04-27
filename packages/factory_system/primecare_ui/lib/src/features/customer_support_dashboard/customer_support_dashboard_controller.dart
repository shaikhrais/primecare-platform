import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'customer_support_dashboard_model.dart';

final customerSupportDashboardAdapterProvider = StateNotifierProvider<CustomerSupportDashboardController, AsyncValue<Result<CustomerSupportDashboardViewModel>>>((ref) {
  return CustomerSupportDashboardController(ref);
});

class CustomerSupportDashboardController extends StateNotifier<AsyncValue<Result<CustomerSupportDashboardViewModel>>> {
  final Ref ref;
  
  CustomerSupportDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('customer_support');
      state = AsyncValue.data(result.map((metrics) => CustomerSupportDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
