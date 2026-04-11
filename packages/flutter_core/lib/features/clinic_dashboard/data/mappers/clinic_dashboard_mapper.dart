import '../../domain/models/clinic_dashboard_view_model.dart';
import '../dtos/clinic_dashboard_dto.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class ClinicDashboardMapper {
  static ClinicDashboardViewModel fromApi(ClinicDashboardDto dto) {
    return ClinicDashboardViewModel(
      blueprints: [
        StatGridBlueprint(dataPayload: [],
        ),
        ActivityFeedBlueprint(dataPayload: [],
        ),
      ],
    );
  }

  static ClinicDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return ClinicDashboardViewModel(
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
