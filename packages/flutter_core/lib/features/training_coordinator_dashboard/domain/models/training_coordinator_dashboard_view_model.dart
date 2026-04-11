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

  factory TrainingCoordinatorDashboardViewModel.assemble({required bool isOffline}) {
    return TrainingCoordinatorDashboardViewModel(
      isOfflineFallback: isOffline,
      blueprints: [
        // Standard Zero-Code Orchestration Layout
        StatGridBlueprint(dataPayload: []), // Dynamic KPIs
        ActivityFeedBlueprint(dataPayload: []), // Live Stream
      ],
    );
  }
}
