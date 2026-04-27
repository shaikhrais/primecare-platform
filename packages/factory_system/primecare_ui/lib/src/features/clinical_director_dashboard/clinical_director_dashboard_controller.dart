import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'clinical_director_dashboard_model.dart';

final clinicalDirectorDashboardAdapterProvider = FutureProvider<Result<ClinicalDirectorDashboardViewModel>>((ref) async {
  final service = ref.watch(dashboardServiceProvider);
  
  try {
    final result = await service.getMetrics('clinical_director');
    return result.map((metrics) => ClinicalDirectorDashboardViewModel(
      metrics: metrics,
      insights: const [],
    ));
  } catch (e, st) {
    return Failure(e, st);
  }
});

class ClinicalDirectorDashboardController {
  final WidgetRef ref;
  
  ClinicalDirectorDashboardController(this.ref);
  
  void refresh() {
    ref.refresh(clinicalDirectorDashboardAdapterProvider);
  }
}
