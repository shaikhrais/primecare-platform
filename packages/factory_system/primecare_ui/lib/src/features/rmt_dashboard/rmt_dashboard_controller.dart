import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final rmtDashboardAdapterProvider =
    StateNotifierProvider<
      RmtDashboardController,
      AsyncValue<Result<RmtDashboardViewModel>>
    >((ref) {
      return RmtDashboardController(ref);
    });

class RmtDashboardController
    extends StateNotifier<AsyncValue<Result<RmtDashboardViewModel>>> {
  final Ref ref;

  RmtDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('rmt');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              RmtDashboardViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
