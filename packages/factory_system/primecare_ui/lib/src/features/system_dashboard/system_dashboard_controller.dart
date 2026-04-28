import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final systemDashboardAdapterProvider =
    StateNotifierProvider<
      SystemDashboardController,
      AsyncValue<Result<SystemDashboardModel>>
    >((ref) {
      return SystemDashboardController();
    });

// Alias for registry compatibility (mapping generalManagerMetricsProvider to this)
final generalManagerMetricsProvider = systemDashboardAdapterProvider;

class SystemDashboardController
    extends StateNotifier<AsyncValue<Result<SystemDashboardModel>>> {
  SystemDashboardController() : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    try {
      await Future<void>.delayed(const Duration(seconds: 1));

      final model = SystemDashboardModel(
        kpis: [
          KpiData(title: 'Global Efficiency', value: '88%', subtitle: 'Stable'),
          KpiData(
            title: 'Active Clinics',
            value: '42',
            subtitle: '3 new this month',
          ),
          KpiData(
            title: 'Patient Satisfaction',
            value: '4.8/5',
            subtitle: 'Excellent',
          ),
          KpiData(
            title: 'Budget Compliance',
            value: '92%',
            subtitle: 'On target',
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
