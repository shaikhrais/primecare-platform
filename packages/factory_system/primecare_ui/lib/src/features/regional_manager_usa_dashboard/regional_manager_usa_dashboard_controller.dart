import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

class RegionalManagerUsaDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<RegionalManagerUsaDashboardViewModel>>
        > {
  final Ref ref;

  RegionalManagerUsaDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('regional_manager_usa');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => RegionalManagerUsaDashboardViewModel(
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
