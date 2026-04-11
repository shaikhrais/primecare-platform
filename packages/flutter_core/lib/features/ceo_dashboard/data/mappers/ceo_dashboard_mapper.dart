import '../../domain/models/ceo_dashboard_view_model.dart';
import '../dtos/ceo_dashboard_dto.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class CeoDashboardMapper {
  static CeoDashboardViewModel fromApi(CeoDashboardDto dto) {
    return CeoDashboardViewModel(
      blueprints: [
        StatGridBlueprint(
          id: 'stats_primary',
          title: 'KPI Summary',
          dataPayload: [],
        ),
        ActivityFeedBlueprint(
          id: 'activity_primary',
          title: 'Recent Activity',
          dataPayload: [],
        ),
      ],
    );
  }

  static CeoDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return CeoDashboardViewModel(
      isOfflineFallback: isErrorFallback,
      blueprints: [
        StatGridBlueprint(
          id: 'stats_primary',
          title: 'KPI Summary',
          dataPayload: [],
        ),
        ActivityFeedBlueprint(
          id: 'activity_primary',
          title: 'Recent Activity',
          dataPayload: [],
        ),
      ],
    );
  }
}
