import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'head_of_bus_dev_dashboard_model.dart';

final headOfBusDevAdapterProvider = StateNotifierProvider<HeadOfBusDevDashboardController, AsyncValue<Result<HeadOfBusDevDashboardViewModel>>>((ref) {
  return HeadOfBusDevDashboardController(ref);
});

class HeadOfBusDevDashboardController extends StateNotifier<AsyncValue<Result<HeadOfBusDevDashboardViewModel>>> {
  final Ref ref;
  
  HeadOfBusDevDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('head_of_bus_dev');
      state = AsyncValue.data(result.map((metrics) => HeadOfBusDevDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
