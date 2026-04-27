import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'finance_director_dashboard_model.dart';

final financeDirectorDashboardAdapterProvider = StateNotifierProvider<FinanceDirectorDashboardController, AsyncValue<Result<FinanceDirectorDashboardViewModel>>>((ref) {
  return FinanceDirectorDashboardController(ref);
});

class FinanceDirectorDashboardController extends StateNotifier<AsyncValue<Result<FinanceDirectorDashboardViewModel>>> {
  final Ref ref;
  
  FinanceDirectorDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('finance_director');
      state = AsyncValue.data(result.map((metrics) => FinanceDirectorDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
