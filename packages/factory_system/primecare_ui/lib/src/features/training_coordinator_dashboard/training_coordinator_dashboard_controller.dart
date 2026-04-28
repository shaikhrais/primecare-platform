import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final trainingCoordinatorDashboardAdapterProvider =
    StateNotifierProvider<
      TrainingCoordinatorDashboardController,
      AsyncValue<Result<TrainingCoordinatorDashboardViewModel>>
    >((ref) {
      return TrainingCoordinatorDashboardController(ref);
    });

class TrainingCoordinatorDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<TrainingCoordinatorDashboardViewModel>>
        > {
  final Ref ref;

  TrainingCoordinatorDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('training_coordinator');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => TrainingCoordinatorDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
