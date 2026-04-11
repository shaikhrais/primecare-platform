import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class TrainingCoordinatorDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UIComponentBlueprint> blueprints;

  const TrainingCoordinatorDashboardViewModel({
    this.isOfflineFallback = false,
    this.blueprints = const [],
  });
}
