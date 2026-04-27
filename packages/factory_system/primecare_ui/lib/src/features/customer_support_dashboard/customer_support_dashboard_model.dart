import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class CustomerSupportDashboardViewModel extends PrimeCareDashboardViewModel {
  const CustomerSupportDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory CustomerSupportDashboardViewModel.empty() {
    return CustomerSupportDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
