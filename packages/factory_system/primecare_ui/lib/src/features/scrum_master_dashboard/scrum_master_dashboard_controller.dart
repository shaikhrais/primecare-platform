import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final scrumMasterDashboardAdapterProvider =
    StateNotifierProvider<
      ScrumMasterDashboardController,
      AsyncValue<Result<ScrumMasterDashboardViewModel>>
    >((ref) {
      return ScrumMasterDashboardController(ref);
    });

class ScrumMasterDashboardController
    extends StateNotifier<AsyncValue<Result<ScrumMasterDashboardViewModel>>> {
  final Ref ref;

  ScrumMasterDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('scrum_master');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => ScrumMasterDashboardViewModel(
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
