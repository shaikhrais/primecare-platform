import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class GeneralManagerDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UIComponentBlueprint> blueprints;

  const GeneralManagerDashboardViewModel({
    this.isOfflineFallback = false,
    this.blueprints = const [],
  });

  factory GeneralManagerDashboardViewModel.assemble({required bool isOffline}) {
    return GeneralManagerDashboardViewModel(
      isOfflineFallback: isOffline,
      blueprints: [
        // Standard Zero-Code Orchestration Layout
        StatGridBlueprint(dataPayload: []), // Dynamic KPIs
        ActivityFeedBlueprint(dataPayload: []), // Live Stream
      ],
    );
  }
}
