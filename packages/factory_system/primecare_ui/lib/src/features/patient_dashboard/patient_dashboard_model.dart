import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class PatientDashboardViewModel extends PrimeCareDashboardViewModel {
  const PatientDashboardViewModel({
    required super.metrics,
    required super.insights,
  });

  factory PatientDashboardViewModel.empty() {
    return PatientDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
