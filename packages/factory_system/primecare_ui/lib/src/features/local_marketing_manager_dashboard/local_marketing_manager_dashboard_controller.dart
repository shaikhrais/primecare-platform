import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'local_marketing_manager_dashboard_model.dart';

final localMarketingManagerDashboardAdapterProvider = StateNotifierProvider<LocalMarketingManagerDashboardController, AsyncValue<Result<LocalMarketingManagerDashboardViewModel>>>((ref) {
  return LocalMarketingManagerDashboardController(ref);
});

class LocalMarketingManagerDashboardController extends StateNotifier<AsyncValue<Result<LocalMarketingManagerDashboardViewModel>>> {
  final Ref ref;
  
  LocalMarketingManagerDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('local_marketing');
      state = AsyncValue.data(result.map((metrics) => LocalMarketingManagerDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
