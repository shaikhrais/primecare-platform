import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'owner_dashboard_model.dart';

final ownerDashboardAdapterProvider = StateNotifierProvider<OwnerDashboardController, AsyncValue<Result<OwnerDashboardViewModel>>>((ref) {
  return OwnerDashboardController(ref);
});

class OwnerDashboardController extends StateNotifier<AsyncValue<Result<OwnerDashboardViewModel>>> {
  final Ref ref;
  
  OwnerDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('owner');
      state = AsyncValue.data(result.map((metrics) => OwnerDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
