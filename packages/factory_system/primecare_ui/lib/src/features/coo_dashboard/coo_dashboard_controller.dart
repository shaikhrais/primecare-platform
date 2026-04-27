import 'package:primecare_ui/primecare_ui.dart';
import 'coo_dashboard_model.dart';

final cooDashboardAdapterProvider = StateNotifierProvider<COODashboardController, AsyncValue<Either<COODashboardModel, String>>>((ref) {
  return COODashboardController();
});

// Alias for registry compatibility
final cooMetricsProvider = cooDashboardAdapterProvider;

class COODashboardController extends StateNotifier<AsyncValue<Either<COODashboardModel, String>>> {
  COODashboardController() : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      final model = COODashboardModel(
        kpis: [
          KpiData(title: 'Logistics Efficiency', value: '94%', subtitle: 'On track'),
          KpiData(title: 'Warehouse Utilization', value: '78%', subtitle: 'Optimal'),
          KpiData(title: 'Avg Delivery Time', value: '1.2 days', subtitle: '-0.2 days improvement'),
          KpiData(title: 'Active Fleet', value: '45 vehicles', subtitle: '5 in maintenance'),
        ],
      );
      
      state = AsyncValue.data(Left(model));
    } catch (e) {
      state = AsyncValue.data(Right(e.toString()));
    }
  }

  void refresh() => loadData();
}
