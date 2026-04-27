import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'training_director_dashboard_model.dart';

final trainingDirectorDashboardAdapterProvider = StateNotifierProvider<TrainingDirectorDashboardController, AsyncValue<Result<TrainingDirectorDashboardViewModel>>>((ref) {
  return TrainingDirectorDashboardController(ref);
});

class TrainingDirectorDashboardController extends StateNotifier<AsyncValue<Result<TrainingDirectorDashboardViewModel>>> {
  final Ref ref;
  
  TrainingDirectorDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('training_director');
      state = AsyncValue.data(result.map((metrics) => TrainingDirectorDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
