import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final clinicDashboardAdapterProvider =
    FutureProvider<Result<ClinicDashboardModel>>((ref) async {
      final service = ref.watch(dashboardServiceProvider);

      try {
        final result = await service.getMetrics('clinic');
        return result.map(
          (DashboardMetrics metrics) => ClinicDashboardModel(
            metrics: metrics,
            recentActivity: metrics.recentActivity,
          ),
        );
      } catch (e, st) {
        return Failure(e, st);
      }
    });

class ClinicDashboardController {
  final WidgetRef ref;

  ClinicDashboardController(this.ref);

  void refresh() {
    ref.invalidate(clinicDashboardAdapterProvider);
  }
}
