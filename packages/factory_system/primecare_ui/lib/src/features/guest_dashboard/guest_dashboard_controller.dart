import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'guest_dashboard_model.dart';

final guestDashboardAdapterProvider = StateNotifierProvider<GuestDashboardController, AsyncValue<Result<GuestDashboardViewModel>>>((ref) {
  return GuestDashboardController(ref);
});

class GuestDashboardController extends StateNotifier<AsyncValue<Result<GuestDashboardViewModel>>> {
  final Ref ref;
  
  GuestDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('guest');
      state = AsyncValue.data(result.map((metrics) => GuestDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
