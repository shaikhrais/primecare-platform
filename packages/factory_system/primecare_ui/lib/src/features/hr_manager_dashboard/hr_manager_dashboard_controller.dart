import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final hrManagerDashboardAdapterProvider =
    StateNotifierProvider<
      HrManagerDashboardController,
      AsyncValue<Result<HumanResourcesManagerDashboardViewModel>>
    >((ref) {
      return HrManagerDashboardController(ref);
    });

class HrManagerDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<HumanResourcesManagerDashboardViewModel>>
        > {
  final Ref ref;

  HrManagerDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('hr_manager');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => HumanResourcesManagerDashboardViewModel(
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
