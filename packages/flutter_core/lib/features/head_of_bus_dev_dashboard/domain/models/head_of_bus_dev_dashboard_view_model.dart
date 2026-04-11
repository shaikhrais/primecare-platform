import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class HeadOfBusDevDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UIComponentBlueprint> blueprints;

  const HeadOfBusDevDashboardViewModel({
    this.isOfflineFallback = false,
    this.blueprints = const [],
  });
}
