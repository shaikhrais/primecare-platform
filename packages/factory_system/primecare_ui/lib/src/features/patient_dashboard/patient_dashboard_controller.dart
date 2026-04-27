import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'patient_dashboard_model.dart';

final patientDashboardAdapterProvider = FutureProvider<Result<PatientDashboardViewModel>>((ref) async {
  final service = ref.watch(dashboardServiceProvider);
  
  try {
    final result = await service.getMetrics('patient');
    return result.map((metrics) => PatientDashboardViewModel(
      metrics: metrics,
      insights: const [],
    ));
  } catch (e, st) {
    return Failure(e, st);
  }
});

class PatientDashboardController {
  final WidgetRef ref;
  
  PatientDashboardController(this.ref);
  
  void refresh() {
    ref.refresh(patientDashboardAdapterProvider);
  }
}
