import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class FranchiseRefundsDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UIComponentBlueprint> blueprints;

  const FranchiseRefundsDashboardViewModel({
    this.isOfflineFallback = false,
    this.blueprints = const [],
  });
}
