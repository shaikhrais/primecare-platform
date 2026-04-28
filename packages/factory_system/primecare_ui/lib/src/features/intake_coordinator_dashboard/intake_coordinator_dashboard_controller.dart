import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final intakeCoordinatorDashboardAdapterProvider =
    StateNotifierProvider<
      IntakeCoordinatorDashboardController,
      AsyncValue<Result<IntakeCoordinatorDashboardViewModel>>
    >((ref) {
      return IntakeCoordinatorDashboardController(ref);
    });

class IntakeCoordinatorDashboardController
    extends
        StateNotifier<AsyncValue<Result<IntakeCoordinatorDashboardViewModel>>> {
  final Ref ref;

  IntakeCoordinatorDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('intake_coordinator');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => IntakeCoordinatorDashboardViewModel(
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
