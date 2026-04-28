import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final rnAdapterProvider =
    StateNotifierProvider<RnController, AsyncValue<Result<RnViewModel>>>((ref) {
      return RnController(ref);
    });

class RnController extends StateNotifier<AsyncValue<Result<RnViewModel>>> {
  final Ref ref;

  RnController(this.ref) : super(const AsyncValue.loading()) {
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
              RnViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
