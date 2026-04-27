import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'franchise_owner_dashboard_model.dart';

final franchiseOwnerAdapterProvider = StateNotifierProvider<FranchiseOwnerDashboardController, AsyncValue<Result<FranchiseOwnerDashboardViewModel>>>((ref) {
  return FranchiseOwnerDashboardController(ref);
});

class FranchiseOwnerDashboardController extends StateNotifier<AsyncValue<Result<FranchiseOwnerDashboardViewModel>>> {
  final Ref ref;
  
  FranchiseOwnerDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('franchise_owner');
      state = AsyncValue.data(result.map((metrics) => FranchiseOwnerDashboardViewModel(
        metrics: metrics as DashboardMetrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
