import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'support_dashboard_model.dart';

final supportDashboardAdapterProvider = StateNotifierProvider<SupportDashboardController, AsyncValue<Result<SupportDashboardViewModel>>>((ref) {
  return SupportDashboardController(ref);
});

class SupportDashboardController extends StateNotifier<AsyncValue<Result<SupportDashboardViewModel>>> {
  final Ref ref;
  
  SupportDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('support');
      state = AsyncValue.data(result.map((metrics) => SupportDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
