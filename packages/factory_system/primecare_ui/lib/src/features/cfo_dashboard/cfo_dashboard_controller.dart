import 'package:primecare_ui/primecare_ui.dart';

final cfoDashboardAdapterProvider = StateNotifierProvider<CFODashboardController, AsyncValue<Either<CFODashboardModel, String>>>((ref) {
  return CFODashboardController();
});

// Alias for registry compatibility if needed
final cfoMetricsProvider = cfoDashboardAdapterProvider;

class CFODashboardController extends StateNotifier<AsyncValue<Either<CFODashboardModel, String>>> {
  CFODashboardController() : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    try {
      // Mock data for now, real implementation would call a service
      await Future.delayed(const Duration(seconds: 1));
      
      final model = CFODashboardModel(
        kpis: [
          KpiData(title: 'Total Revenue', value: '\$1.2M', subtitle: '+12% from last month'),
          KpiData(title: 'Operating Expenses', value: '\$450K', subtitle: '-5% optimization'),
          KpiData(title: 'Net Profit Margin', value: '28%', subtitle: 'Stable'),
          KpiData(title: 'Outstanding Claims', value: '\$85K', subtitle: '12 pending'),
        ],
      );
      
      state = AsyncValue.data(Left(model));
    } catch (e) {
      state = AsyncValue.data(Right(e.toString()));
    }
  }

  void refresh() => loadData();
}
