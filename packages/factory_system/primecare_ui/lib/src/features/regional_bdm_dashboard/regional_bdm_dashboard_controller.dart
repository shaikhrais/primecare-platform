import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'regional_bdm_dashboard_model.dart';

final regionalBdmDashboardAdapterProvider = StateNotifierProvider<RegionalBdmDashboardController, AsyncValue<Result<RegionalBdmDashboardViewModel>>>((ref) {
  return RegionalBdmDashboardController(ref);
});

class RegionalBdmDashboardController extends StateNotifier<AsyncValue<Result<RegionalBdmDashboardViewModel>>> {
  final Ref ref;
  
  RegionalBdmDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('regional_bdm');
      state = AsyncValue.data(result.map((metrics) => RegionalBdmDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
