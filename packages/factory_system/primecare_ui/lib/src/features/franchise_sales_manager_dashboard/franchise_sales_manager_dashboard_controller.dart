import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'franchise_sales_manager_dashboard_model.dart';

final franchiseSalesAdapterProvider = StateNotifierProvider<FranchiseSalesManagerDashboardController, AsyncValue<Result<FranchiseSalesManagerDashboardViewModel>>>((ref) {
  return FranchiseSalesManagerDashboardController(ref);
});

class FranchiseSalesManagerDashboardController extends StateNotifier<AsyncValue<Result<FranchiseSalesManagerDashboardViewModel>>> {
  final Ref ref;
  
  FranchiseSalesManagerDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('franchise_sales_manager');
      state = AsyncValue.data(result.map((metrics) => FranchiseSalesManagerDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
