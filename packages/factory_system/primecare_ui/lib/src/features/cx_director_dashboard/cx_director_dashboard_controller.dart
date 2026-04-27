import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'cx_director_dashboard_model.dart';

final cxDirectorDashboardAdapterProvider = StateNotifierProvider<CXDirectorDashboardController, AsyncValue<Result<CXDirectorDashboardViewModel>>>((ref) {
  return CXDirectorDashboardController(ref);
});

class CXDirectorDashboardController extends StateNotifier<AsyncValue<Result<CXDirectorDashboardViewModel>>> {
  final Ref ref;
  
  CXDirectorDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('cx_director');
      state = AsyncValue.data(result.map((metrics) => CXDirectorDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
