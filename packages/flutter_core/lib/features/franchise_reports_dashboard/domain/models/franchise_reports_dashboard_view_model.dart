import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class FranchiseReportsDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UIComponentBlueprint> blueprints;

  const FranchiseReportsDashboardViewModel({
    this.isOfflineFallback = false,
    this.blueprints = const [],
  });

  factory FranchiseReportsDashboardViewModel.assemble({required bool isOffline}) {
    return FranchiseReportsDashboardViewModel(
      isOfflineFallback: isOffline,
      blueprints: [
        // Standard Zero-Code Orchestration Layout
        StatGridBlueprint(dataPayload: []), // Dynamic KPIs
        ActivityFeedBlueprint(dataPayload: []), // Live Stream
      ],
    );
  }
}
