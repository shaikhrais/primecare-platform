import 'package:primecare_ui/src/features/features_controller.dart';
import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/shared/controller_infrastructure.dart';

// Alias for registry compatibility
final cooMetricsProvider = cooDashboardAdapterProvider;

class COODashboardController
    extends StateNotifier<AsyncValue<Result<COODashboardModel>>> {
  COODashboardController() : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    try {
      await Future<void>.delayed(const Duration(seconds: 1));

      final model = COODashboardModel(
        kpis: [
          KpiData(
            title: 'Logistics Efficiency',
            value: '94%',
            subtitle: 'On track',
          ),
          KpiData(
            title: 'Warehouse Utilization',
            value: '78%',
            subtitle: 'Optimal',
          ),
          KpiData(
            title: 'Avg Delivery Time',
            value: '1.2 days',
            subtitle: '-0.2 days improvement',
          ),
          KpiData(
            title: 'Active Fleet',
            value: '45 vehicles',
            subtitle: '5 in maintenance',
          ),
        ],
      );

      state = AsyncValue.data(Success(model));
    } catch (e) {
      state = AsyncValue.data(Failure(e));
    }
  }

  void refresh() => loadData();
}
