import 'package:primecare_ui/primecare_ui.dart';
import 'cto_dashboard_model.dart';

final ctoDashboardAdapterProvider = StateNotifierProvider<CTODashboardController, AsyncValue<Either<CTODashboardModel, String>>>((ref) {
  return CTODashboardController();
});

// Alias for registry compatibility
final ctoMetricsProvider = ctoDashboardAdapterProvider;

class CTODashboardController extends StateNotifier<AsyncValue<Either<CTODashboardModel, String>>> {
  CTODashboardController() : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      final model = CTODashboardModel(
        kpis: [
          KpiData(title: 'System Uptime', value: '99.99%', subtitle: 'High availability'),
          KpiData(title: 'Active Users', value: '1,240', subtitle: '+15% this week'),
          KpiData(title: 'API Latency', value: '120ms', subtitle: '-10ms optimization'),
          KpiData(title: 'Security Incidents', value: '0', subtitle: 'All clear'),
        ],
      );
      
      state = AsyncValue.data(Left(model));
    } catch (e) {
      state = AsyncValue.data(Right(e.toString()));
    }
  }

  void refresh() => loadData();
}
