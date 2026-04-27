import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'billing_admin_dashboard_model.dart';

final billingAdminDashboardAdapterProvider = FutureProvider<Result<BillingAdminDashboardViewModel>>((ref) async {
  final service = ref.watch(dashboardServiceProvider);
  
  try {
    final result = await service.getMetrics('billing');
    return result.map((metrics) => BillingAdminDashboardViewModel(
      metrics: metrics,
      insights: const [],
    ));
  } catch (e, st) {
    return Failure(e, st);
  }
});

class BillingAdminDashboardController {
  final WidgetRef ref;
  
  BillingAdminDashboardController(this.ref);
  
  void refresh() {
    ref.refresh(billingAdminDashboardAdapterProvider);
  }
}
