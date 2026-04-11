import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class CommunityOutreachDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UIComponentBlueprint> blueprints;

  const CommunityOutreachDashboardViewModel({
    this.isOfflineFallback = false,
    this.blueprints = const [],
  });
}
