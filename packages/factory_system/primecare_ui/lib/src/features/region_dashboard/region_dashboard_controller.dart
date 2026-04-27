import 'package:primecare_ui/primecare_ui.dart';
import 'region_dashboard_model.dart';

final regionDashboardAdapterProvider = StateNotifierProvider<RegionDashboardController, AsyncValue<Either<RegionDashboardModel, String>>>((ref) {
  return RegionDashboardController();
});

// Alias for registry compatibility
final regionalManagerOntarioMetricsProvider = regionDashboardAdapterProvider;

class RegionDashboardController extends StateNotifier<AsyncValue<Either<RegionDashboardModel, String>>> {
  RegionDashboardController() : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      final model = RegionDashboardModel(
        kpis: [
          KpiData(title: 'Regional Growth', value: '15%', subtitle: 'Ahead of target'),
          KpiData(title: 'Clinic Density', value: '8.2', subtitle: 'Per 100k pop'),
          KpiData(title: 'Resource Utilization', value: '82%', subtitle: 'Optimized'),
          KpiData(title: 'Compliance Rate', value: '98%', subtitle: 'High'),
        ],
      );
      
      state = AsyncValue.data(Left(model));
    } catch (e) {
      state = AsyncValue.data(Right(e.toString()));
    }
  }

  void refresh() => loadData();
}
