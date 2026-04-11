import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class TrainingDirectorDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UIComponentBlueprint> blueprints;

  const TrainingDirectorDashboardViewModel({
    this.isOfflineFallback = false,
    this.blueprints = const [],
  });
}
