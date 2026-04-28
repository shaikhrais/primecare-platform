import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final communityOutreachDashboardAdapterProvider =
    FutureProvider<Result<CommunityOutreachDashboardViewModel>>((ref) async {
      final service = ref.watch(dashboardServiceProvider);

      try {
        final result = await service.getMetrics('community_outreach');
        return result.map(
          (DashboardMetrics metrics) => CommunityOutreachDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        );
      } catch (e, st) {
        return Failure(e, st);
      }
    });

class CommunityOutreachDashboardController {
  final WidgetRef ref;

  CommunityOutreachDashboardController(this.ref);

  void refresh() {
    ref.invalidate(communityOutreachDashboardAdapterProvider);
  }
}
