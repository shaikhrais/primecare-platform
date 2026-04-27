import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'training_director_certificate_dashboard_model.dart';

final trainingDirectorCertDashboardAdapterProvider = StateNotifierProvider<TrainingDirectorCertificateDashboardController, AsyncValue<Result<TrainingDirectorCertificateDashboardViewModel>>>((ref) {
  return TrainingDirectorCertificateDashboardController(ref);
});

class TrainingDirectorCertificateDashboardController extends StateNotifier<AsyncValue<Result<TrainingDirectorCertificateDashboardViewModel>>> {
  final Ref ref;
  
  TrainingDirectorCertificateDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('training_director_certificate');
      state = AsyncValue.data(result.map((metrics) => TrainingDirectorCertificateDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
