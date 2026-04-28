import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final regionalManagerOntarioDashboardAdapterProvider =
    StateNotifierProvider<
      RegionalManagerOntarioDashboardController,
      AsyncValue<Result<RegionalManagerOntarioDashboardViewModel>>
    >((ref) {
      return RegionalManagerOntarioDashboardController(ref);
    });

class RegionalManagerOntarioDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<RegionalManagerOntarioDashboardViewModel>>
        > {
  final Ref ref;

  RegionalManagerOntarioDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('regional_manager_ontario');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              RegionalManagerOntarioDashboardViewModel(
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
