import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide Result;

import 'intake_coordinator_model.dart';

final intakeCoordinatorAdapterProvider = StateNotifierProvider<IntakeCoordinatorController, AsyncValue<Result<IntakeCoordinatorViewModel>>>((ref) {
  return IntakeCoordinatorController(ref);
});

class IntakeCoordinatorController extends StateNotifier<AsyncValue<Result<IntakeCoordinatorViewModel>>> {
  final Ref ref;
  
  IntakeCoordinatorController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('intake_coordinator');
      state = AsyncValue.data(result.map((metrics) => IntakeCoordinatorViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
