import '../../domain/models/client_dashboard_view_model.dart';
import '../dtos/client_dashboard_dto.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class ClientDashboardMapper {
  static ClientDashboardViewModel fromApi(ClientDashboardDto dto) {
    return ClientDashboardViewModel(
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

  static ClientDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return ClientDashboardViewModel(
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
