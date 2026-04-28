import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final rnDashboardAdapterProvider =
    StateNotifierProvider<
      RnDashboardController,
      AsyncValue<Result<RnDashboardViewModel>>
    >((ref) {
      return RnDashboardController(ref);
    });

class RnDashboardController
    extends StateNotifier<AsyncValue<Result<RnDashboardViewModel>>> {
  final Ref ref;

  RnDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('rn');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              RnDashboardViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
