import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'community_outreach_dashboard_model.dart';

final communityOutreachDashboardAdapterProvider = FutureProvider<Result<CommunityOutreachDashboardViewModel>>((ref) async {
  final service = ref.watch(dashboardServiceProvider);
  
  try {
    final result = await service.getMetrics('community_outreach');
    return result.map((metrics) => CommunityOutreachDashboardViewModel(
      metrics: metrics,
      insights: const [],
    ));
  } catch (e, st) {
    return Failure(e, st);
  }
});

class CommunityOutreachDashboardController {
  final WidgetRef ref;
  
  CommunityOutreachDashboardController(this.ref);
  
  void refresh() {
    ref.refresh(communityOutreachDashboardAdapterProvider);
  }
}
