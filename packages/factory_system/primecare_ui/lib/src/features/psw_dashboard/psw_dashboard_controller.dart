import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'psw_dashboard_model.dart';

final pswDashboardAdapterProvider = StateNotifierProvider<PswDashboardController, AsyncValue<Result<PswDashboardViewModel>>>((ref) {
  return PswDashboardController(ref);
});

class PswDashboardController extends StateNotifier<AsyncValue<Result<PswDashboardViewModel>>> {
  final Ref ref;
  
  PswDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('psw');
      state = AsyncValue.data(result.map((metrics) => PswDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
