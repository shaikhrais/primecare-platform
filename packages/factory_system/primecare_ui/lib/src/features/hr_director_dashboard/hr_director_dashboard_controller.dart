import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final hrDirectorDashboardAdapterProvider =
    StateNotifierProvider<
      HrDirectorDashboardController,
      AsyncValue<Result<HumanResourcesDirectorDashboardViewModel>>
    >((ref) {
      return HrDirectorDashboardController(ref);
    });

class HrDirectorDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<HumanResourcesDirectorDashboardViewModel>>
        > {
  final Ref ref;

  HrDirectorDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('hr_director');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              HumanResourcesDirectorDashboardViewModel(
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
