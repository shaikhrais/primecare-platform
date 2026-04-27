import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'training_hub_dashboard_model.dart';

final trainingHubDashboardAdapterProvider = StateNotifierProvider<TrainingHubDashboardController, AsyncValue<Result<TrainingHubDashboardViewModel>>>((ref) {
  return TrainingHubDashboardController(ref);
});

class TrainingHubDashboardController extends StateNotifier<AsyncValue<Result<TrainingHubDashboardViewModel>>> {
  final Ref ref;
  
  TrainingHubDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('training_hub');
      state = AsyncValue.data(result.map((metrics) => TrainingHubDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
