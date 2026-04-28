import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final verificationHubAdapterProvider =
    FutureProvider<Result<VerificationHubModel>>((ref) async {
      final service = ref.watch(dashboardServiceProvider);

      try {
        // Verification Hub might use 'verification_hub' or similar
        final result = await service.getMetrics('verification_hub');
        return result.map(
          (DashboardMetrics metrics) =>
              VerificationHubModel(metrics: metrics, insights: const []),
        );
      } catch (e, st) {
        return Failure(e, st);
      }
    });

class VerificationHubController {
  final WidgetRef ref;

  VerificationHubController(this.ref);

  void refresh() {
    ref.invalidate(verificationHubAdapterProvider);
  }
}
