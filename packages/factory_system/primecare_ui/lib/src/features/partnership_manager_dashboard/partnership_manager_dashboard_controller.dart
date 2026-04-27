import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide Result;

import 'partnership_manager_dashboard_model.dart';

final partnershipManagerDashboardAdapterProvider = StateNotifierProvider<PartnershipManagerDashboardController, AsyncValue<Result<PartnershipManagerDashboardViewModel>>>((ref) {
  return PartnershipManagerDashboardController(ref);
});

class PartnershipManagerDashboardController extends StateNotifier<AsyncValue<Result<PartnershipManagerDashboardViewModel>>> {
  final Ref ref;
  
  PartnershipManagerDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('partnership_manager');
      state = AsyncValue.data(result.map((metrics) => PartnershipManagerDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
