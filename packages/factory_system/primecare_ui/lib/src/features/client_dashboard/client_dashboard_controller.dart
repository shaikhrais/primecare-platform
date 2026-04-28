import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final clientDashboardAdapterProvider =
    FutureProvider<Result<ClientDashboardViewModel>>((ref) async {
      final service = ref.watch(dashboardServiceProvider);

      try {
        final result = await service.getMetrics('client');
        return result.map(
          (DashboardMetrics metrics) =>
              ClientDashboardViewModel(metrics: metrics, insights: const []),
        );
      } catch (e, st) {
        return Failure(e, st);
      }
    });

class ClientDashboardController {
  final WidgetRef ref;

  ClientDashboardController(this.ref);

  void refresh() {
    ref.invalidate(clientDashboardAdapterProvider);
  }
}
