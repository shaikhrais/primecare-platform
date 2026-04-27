import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'social_worker_dashboard_model.dart';

final socialWorkerDashboardAdapterProvider = StateNotifierProvider<SocialWorkerDashboardController, AsyncValue<Result<SocialWorkerDashboardViewModel>>>((ref) {
  return SocialWorkerDashboardController(ref);
});

final socialWorkerActionHandler = Provider((ref) => (String action) {
  // Action logic here
});

class SocialWorkerDashboardController extends StateNotifier<AsyncValue<Result<SocialWorkerDashboardViewModel>>> {
  final Ref ref;
  
  SocialWorkerDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('social_worker');
      state = AsyncValue.data(result.map((metrics) => SocialWorkerDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
