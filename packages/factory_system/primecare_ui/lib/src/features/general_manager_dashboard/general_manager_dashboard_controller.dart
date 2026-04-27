import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'general_manager_dashboard_model.dart';

final generalManagerAdapterProvider = StateNotifierProvider<GeneralManagerDashboardController, AsyncValue<Result<GeneralManagerDashboardViewModel>>>((ref) {
  return GeneralManagerDashboardController(ref);
});

class GeneralManagerDashboardController extends StateNotifier<AsyncValue<Result<GeneralManagerDashboardViewModel>>> {
  final Ref ref;
  
  GeneralManagerDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('general_manager');
      state = AsyncValue.data(result.map((metrics) => GeneralManagerDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
