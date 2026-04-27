import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'family_member_dashboard_model.dart';

final familyMemberDashboardAdapterProvider = StateNotifierProvider<FamilyMemberDashboardController, AsyncValue<Result<FamilyMemberDashboardViewModel>>>((ref) {
  return FamilyMemberDashboardController(ref);
});

class FamilyMemberDashboardController extends StateNotifier<AsyncValue<Result<FamilyMemberDashboardViewModel>>> {
  final Ref ref;
  
  FamilyMemberDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('family_member');
      state = AsyncValue.data(result.map((metrics) => FamilyMemberDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
