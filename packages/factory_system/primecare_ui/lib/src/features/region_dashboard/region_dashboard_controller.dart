import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final regionDashboardAdapterProvider =
    StateNotifierProvider<
      RegionDashboardController,
      AsyncValue<Result<RegionDashboardModel>>
    >((ref) {
      return RegionDashboardController();
    });

// Alias for registry compatibility
final regionalManagerOntarioMetricsProvider = regionDashboardAdapterProvider;

class RegionDashboardController
    extends StateNotifier<AsyncValue<Result<RegionDashboardModel>>> {
  RegionDashboardController() : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    try {
      await Future<void>.delayed(const Duration(seconds: 1));

      final model = RegionDashboardModel(
        kpis: [
          KpiData(
            title: 'Regional Growth',
            value: '15%',
            subtitle: 'Ahead of target',
          ),
          KpiData(
            title: 'Clinic Density',
            value: '8.2',
            subtitle: 'Per 100k pop',
          ),
          KpiData(
            title: 'Resource Utilization',
            value: '82%',
            subtitle: 'Optimized',
          ),
          KpiData(title: 'Compliance Rate', value: '98%', subtitle: 'High'),
        ],
      );

      state = AsyncValue.data(Success(model));
    } catch (e) {
      state = AsyncValue.data(Failure(e));
    }
  }

  void refresh() => loadData();
}
