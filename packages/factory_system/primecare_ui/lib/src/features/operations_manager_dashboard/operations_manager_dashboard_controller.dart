import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'operations_manager_dashboard_model.dart';

final operationsManagerDashboardAdapterProvider = StateNotifierProvider<OperationsManagerDashboardController, AsyncValue<Result<OperationsManagerDashboardViewModel>>>((ref) {
  return OperationsManagerDashboardController(ref);
});

class OperationsManagerDashboardController extends StateNotifier<AsyncValue<Result<OperationsManagerDashboardViewModel>>> {
  final Ref ref;
  
  OperationsManagerDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('operations_manager');
      state = AsyncValue.data(result.map((metrics) => OperationsManagerDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
