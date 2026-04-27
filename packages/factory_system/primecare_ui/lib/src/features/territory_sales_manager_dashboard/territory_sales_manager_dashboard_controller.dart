import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'territory_sales_manager_dashboard_model.dart';

final territorySalesManagerDashboardAdapterProvider = StateNotifierProvider<TerritorySalesManagerDashboardController, AsyncValue<Result<TerritorySalesManagerDashboardViewModel>>>((ref) {
  return TerritorySalesManagerDashboardController(ref);
});

class TerritorySalesManagerDashboardController extends StateNotifier<AsyncValue<Result<TerritorySalesManagerDashboardViewModel>>> {
  final Ref ref;
  
  TerritorySalesManagerDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('territory_sales_manager');
      state = AsyncValue.data(result.map((metrics) => TerritorySalesManagerDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
