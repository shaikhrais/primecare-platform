import '../../domain/models/scheduler_dashboard_view_model.dart';
import '../dtos/scheduler_dashboard_dto.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class SchedulerDashboardMapper {
  static SchedulerDashboardViewModel fromApi(SchedulerDashboardDto dto) {
    return SchedulerDashboardViewModel(
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

  static SchedulerDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return SchedulerDashboardViewModel(
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
