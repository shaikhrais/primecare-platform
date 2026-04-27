import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'volunteer_coordinator_dashboard_model.dart';

final volunteerCoordinatorDashboardAdapterProvider = StateNotifierProvider<VolunteerCoordinatorDashboardController, AsyncValue<Result<VolunteerCoordinatorDashboardViewModel>>>((ref) {
  return VolunteerCoordinatorDashboardController(ref);
});

class VolunteerCoordinatorDashboardController extends StateNotifier<AsyncValue<Result<VolunteerCoordinatorDashboardViewModel>>> {
  final Ref ref;
  
  VolunteerCoordinatorDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('volunteer_coordinator');
      state = AsyncValue.data(result.map((metrics) => VolunteerCoordinatorDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
