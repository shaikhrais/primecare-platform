import 'package:primecare_ui/src/features/features_controller.dart';
import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/shared/controller_infrastructure.dart';

// Alias for registry compatibility
final ctoMetricsProvider = ctoDashboardAdapterProvider;

class CTODashboardController
    extends StateNotifier<AsyncValue<Result<CTODashboardModel>>> {
  CTODashboardController() : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    try {
      await Future<void>.delayed(const Duration(seconds: 1));

      final model = CTODashboardModel(
        kpis: [
          KpiData(
            title: 'System Uptime',
            value: '99.99%',
            subtitle: 'High availability',
          ),
          KpiData(
            title: 'Active Users',
            value: '1,240',
            subtitle: '+15% this week',
          ),
          KpiData(
            title: 'API Latency',
            value: '120ms',
            subtitle: '-10ms optimization',
          ),
          KpiData(
            title: 'Security Incidents',
            value: '0',
            subtitle: 'All clear',
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
