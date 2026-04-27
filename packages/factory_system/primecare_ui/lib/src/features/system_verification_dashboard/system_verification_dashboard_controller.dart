import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'system_verification_dashboard_model.dart';

final systemVerificationDashboardAdapterProvider = StateNotifierProvider<SystemVerificationDashboardController, AsyncValue<Result<SystemVerificationDashboardViewModel>>>((ref) {
  return SystemVerificationDashboardController(ref);
});

class SystemVerificationDashboardController extends StateNotifier<AsyncValue<Result<SystemVerificationDashboardViewModel>>> {
  final Ref ref;
  
  SystemVerificationDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('system_verification');
      state = AsyncValue.data(result.map((metrics) => SystemVerificationDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
