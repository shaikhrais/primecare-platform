import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'clinic_dashboard_model.dart';

final clinicDashboardAdapterProvider = FutureProvider<Result<ClinicDashboardModel>>((ref) async {
  final service = ref.watch(dashboardServiceProvider);
  
  try {
    final result = await service.getMetrics('clinic');
    return result.map((metrics) => ClinicDashboardModel(
      metrics: metrics,
      recentActivity: metrics.recentActivity,
    ));
  } catch (e, st) {
    return Failure(e, st);
  }
});

class ClinicDashboardController {
  final WidgetRef ref;
  
  ClinicDashboardController(this.ref);
  
  void refresh() {
    ref.refresh(clinicDashboardAdapterProvider);
  }
}
