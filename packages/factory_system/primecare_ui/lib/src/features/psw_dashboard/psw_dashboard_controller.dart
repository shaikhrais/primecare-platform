import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final pswDashboardAdapterProvider =
    StateNotifierProvider<
      PswDashboardController,
      AsyncValue<Result<PswDashboardViewModel>>
    >((ref) {
      return PswDashboardController(ref);
    });

class PswDashboardController
    extends StateNotifier<AsyncValue<Result<PswDashboardViewModel>>> {
  final Ref ref;

  PswDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('psw');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              PswDashboardViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
