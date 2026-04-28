import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final regionalManagerDashboardAdapterProvider =
    StateNotifierProvider<
      RegionalManagerDashboardController,
      AsyncValue<Result<RegionalManagerDashboardViewModel>>
    >((ref) {
      return RegionalManagerDashboardController(ref);
    });

class RegionalManagerDashboardController
    extends
        StateNotifier<AsyncValue<Result<RegionalManagerDashboardViewModel>>> {
  final Ref ref;

  RegionalManagerDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('regional_manager');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => RegionalManagerDashboardViewModel(
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
