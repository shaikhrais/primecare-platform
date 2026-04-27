import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'dynamic_screen_dashboard_model.dart';

final dynamicScreenDashboardAdapterProvider = StateNotifierProvider<DynamicScreenDashboardController, AsyncValue<Result<DynamicScreenDashboardViewModel>>>((ref) {
  return DynamicScreenDashboardController(ref);
});

class DynamicScreenDashboardController extends StateNotifier<AsyncValue<Result<DynamicScreenDashboardViewModel>>> {
  final Ref ref;
  
  DynamicScreenDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('dynamic_screen');
      state = AsyncValue.data(result.map((metrics) => DynamicScreenDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
