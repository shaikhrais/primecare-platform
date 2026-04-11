import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class CfoDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UIComponentBlueprint> blueprints;

  const CfoDashboardViewModel({
    this.isOfflineFallback = false,
    this.blueprints = const [],
  });

  factory CfoDashboardViewModel.assemble({required bool isOffline}) {
    return CfoDashboardViewModel(
      isOfflineFallback: isOffline,
      blueprints: [
        // Standard Zero-Code Orchestration Layout
        StatGridBlueprint(dataPayload: []), // Dynamic KPIs
        ActivityFeedBlueprint(dataPayload: []), // Live Stream
      ],
    );
  }
}
