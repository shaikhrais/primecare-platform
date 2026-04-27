import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'scheduler_dashboard_model.dart';

final schedulerDashboardAdapterProvider = StateNotifierProvider<SchedulerDashboardController, AsyncValue<Result<SchedulerDashboardViewModel>>>((ref) {
  return SchedulerDashboardController(ref);
});

class SchedulerDashboardController extends StateNotifier<AsyncValue<Result<SchedulerDashboardViewModel>>> {
  final Ref ref;
  
  SchedulerDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('scheduler');
      state = AsyncValue.data(result.map((metrics) => SchedulerDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
