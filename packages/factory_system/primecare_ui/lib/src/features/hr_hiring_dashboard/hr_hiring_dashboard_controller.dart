import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'hr_hiring_dashboard_model.dart';

final hrHiringDashboardAdapterProvider = StateNotifierProvider<HrHiringDashboardController, AsyncValue<Result<HrHiringDashboardViewModel>>>((ref) {
  return HrHiringDashboardController(ref);
});

class HrHiringDashboardController extends StateNotifier<AsyncValue<Result<HrHiringDashboardViewModel>>> {
  final Ref ref;
  
  HrHiringDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('hr_hiring');
      state = AsyncValue.data(result.map((metrics) => HrHiringDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
