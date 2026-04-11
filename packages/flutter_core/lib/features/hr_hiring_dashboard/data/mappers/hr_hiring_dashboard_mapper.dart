import '../../domain/models/hr_hiring_dashboard_view_model.dart';
import '../dtos/hr_hiring_dashboard_dto.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class HrHiringDashboardMapper {
  static HrHiringDashboardViewModel fromApi(HrHiringDashboardDto dto) {
    return HrHiringDashboardViewModel(
      blueprints: [
        StatGridBlueprint(dataPayload: [],
        ),
        ActivityFeedBlueprint(dataPayload: [],
        ),
      ],
    );
  }

  static HrHiringDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return HrHiringDashboardViewModel(
      isOfflineFallback: isErrorFallback,
      blueprints: [
        StatGridBlueprint(dataPayload: [],
        ),
        ActivityFeedBlueprint(dataPayload: [],
        ),
      ],
    );
  }
}
