import 'package:primecare_ui/src/features/features_controller.dart';
import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

// Alias for registry compatibility
final cooMetricsProvider = cooDashboardAdapterProvider;

class COODashboardController
    extends StateNotifier<AsyncValue<Result<COODashboardViewModel>>> {
  COODashboardController() : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    try {
      await Future<void>.delayed(const Duration(seconds: 1));

      final model = COODashboardViewModel(
        metrics: DashboardMetrics(
          kpis: [
            KpiMetric(
              title: 'Logistics Efficiency',
              value: '94%',
              subtitle: 'On track',
              status: 'positive',
            ),
            KpiMetric(
              title: 'Warehouse Utilization',
              value: '78%',
              subtitle: 'Optimal',
              status: 'neutral',
            ),
            KpiMetric(
              title: 'Avg Delivery Time',
              value: '1.2 days',
              subtitle: '-0.2 days improvement',
              status: 'positive',
            ),
            KpiMetric(
              title: 'Active Fleet',
              value: '45 vehicles',
              subtitle: '5 in maintenance',
              status: 'neutral',
            ),
          ],
          recentActivity: [],
        ),
        insights: const [],
      );

      state = AsyncValue.data(Success(model));
    } catch (e) {
      state = AsyncValue.data(Failure(e));
    }
  }

  void refresh() => loadData();
}
