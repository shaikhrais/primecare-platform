import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'ceo_dashboard_model.dart';

final ceoDashboardAdapterProvider = FutureProvider<Result<CeoDashboardModel>>((ref) async {
  final service = ref.watch(dashboardServiceProvider);
  
  try {
    final result = await service.getMetrics('ceo');
    return result.map((metrics) => CeoDashboardModel(
      metrics: metrics,
      insights: const [], // TODO: Fetch real insights
    ));
  } catch (e, st) {
    return Failure(e, st);
  }
});

// Alias for backwards compatibility
final ceoMetricsProvider = ceoDashboardAdapterProvider;

class CeoDashboardController {
  final WidgetRef ref;
  
  CeoDashboardController(this.ref);
  
  void refresh() {
    ref.refresh(ceoDashboardAdapterProvider);
  }
}
