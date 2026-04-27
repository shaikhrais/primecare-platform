import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'compliance_hub_model.dart';

final complianceHubAdapterProvider = FutureProvider<Result<ComplianceHubModel>>((ref) async {
  final service = ref.watch(dashboardServiceProvider);
  
  try {
    // Using 'compliance_manager' as the role identifier for metrics
    final result = await service.getMetrics('compliance_manager');
    return result.map((metrics) => ComplianceHubModel(
      metrics: metrics,
      insights: const [],
    ));
  } catch (e, st) {
    return Failure(e, st);
  }
});

// Alias for backwards compatibility with registry lookups
final complianceManagerDashboardAdapterProvider = complianceHubAdapterProvider;

class ComplianceHubController {
  final WidgetRef ref;
  
  ComplianceHubController(this.ref);
  
  void refresh() {
    ref.refresh(complianceHubAdapterProvider);
  }
}
