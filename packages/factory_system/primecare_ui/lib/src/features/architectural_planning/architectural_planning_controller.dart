import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'architectural_planning_model.dart';

final architecturalPlanningAdapterProvider = FutureProvider<Result<ArchitecturalPlanningModel>>((ref) async {
  final service = ref.watch(dashboardServiceProvider);
  
  try {
    // Architectural Planning might use 'cto' or similar, but let's try a specific role
    final result = await service.getMetrics('architectural_planning');
    return result.map((metrics) => ArchitecturalPlanningModel(
      metrics: metrics,
      insights: const [],
    ));
  } catch (e, st) {
    return Failure(e, st);
  }
});

class ArchitecturalPlanningController {
  final WidgetRef ref;
  
  ArchitecturalPlanningController(this.ref);
  
  void refresh() {
    ref.refresh(architecturalPlanningAdapterProvider);
  }
}
