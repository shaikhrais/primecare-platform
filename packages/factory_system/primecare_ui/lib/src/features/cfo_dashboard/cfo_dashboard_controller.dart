import 'package:primecare_ui/src/features/features_controller.dart';
import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/shared/controller_infrastructure.dart';

// Alias for registry compatibility if needed
final cfoMetricsProvider = cfoDashboardAdapterProvider;

class CFODashboardController
    extends StateNotifier<AsyncValue<Result<CFODashboardModel>>> {
  CFODashboardController() : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    try {
      // Mock data for now, real implementation would call a service
      await Future<void>.delayed(const Duration(seconds: 1));

      final model = CFODashboardModel(
        kpis: [
          KpiData(
            title: 'Total Revenue',
            value: '\$1.2M',
            subtitle: '+12% from last month',
          ),
          KpiData(
            title: 'Operating Expenses',
            value: '\$450K',
            subtitle: '-5% optimization',
          ),
          KpiData(title: 'Net Profit Margin', value: '28%', subtitle: 'Stable'),
          KpiData(
            title: 'Outstanding Claims',
            value: '\$85K',
            subtitle: '12 pending',
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
