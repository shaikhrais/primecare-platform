import '../../domain/models/cto_dashboard_view_model.dart';
import '../dtos/cto_dashboard_dto.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class CtoDashboardMapper {
  static CtoDashboardViewModel fromApi(CtoDashboardDto dto) {
    return CtoDashboardViewModel(
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

  static CtoDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return CtoDashboardViewModel(
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
