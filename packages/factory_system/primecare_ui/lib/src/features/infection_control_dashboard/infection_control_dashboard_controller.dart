import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'infection_control_dashboard_model.dart';

final infectionControlDashboardAdapterProvider = StateNotifierProvider<InfectionControlDashboardController, AsyncValue<Result<InfectionControlDashboardViewModel>>>((ref) {
  return InfectionControlDashboardController(ref);
});

class InfectionControlDashboardController extends StateNotifier<AsyncValue<Result<InfectionControlDashboardViewModel>>> {
  final Ref ref;
  
  InfectionControlDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('infection_control');
      state = AsyncValue.data(result.map((metrics) => InfectionControlDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
