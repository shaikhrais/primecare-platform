import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'receptionist_dashboard_model.dart';

final receptionistDashboardAdapterProvider = StateNotifierProvider<ReceptionistDashboardController, AsyncValue<Result<ReceptionistDashboardViewModel>>>((ref) {
  return ReceptionistDashboardController(ref);
});

class ReceptionistDashboardController extends StateNotifier<AsyncValue<Result<ReceptionistDashboardViewModel>>> {
  final Ref ref;
  
  ReceptionistDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('receptionist');
      state = AsyncValue.data(result.map((metrics) => ReceptionistDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
