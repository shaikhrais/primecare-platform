import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final rpnDashboardAdapterProvider =
    StateNotifierProvider<RpnController, AsyncValue<Result<RpnViewModel>>>((
      ref,
    ) {
      return RpnController(ref);
    });

class RpnController extends StateNotifier<AsyncValue<Result<RpnViewModel>>> {
  final Ref ref;

  RpnController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final result = await ref.read(dashboardMetricsProvider('rpn').future);

    state = AsyncValue.data(
      result.map(
        (DashboardMetrics metrics) =>
            RpnViewModel(metrics: metrics, insights: const []),
      ),
    );
  }
}
