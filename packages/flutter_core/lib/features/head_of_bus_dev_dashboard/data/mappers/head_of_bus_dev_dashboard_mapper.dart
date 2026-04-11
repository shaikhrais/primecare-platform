import '../../domain/models/head_of_bus_dev_dashboard_view_model.dart';
import '../dtos/head_of_bus_dev_dashboard_dto.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class HeadOfBusDevDashboardMapper {
  static HeadOfBusDevDashboardViewModel fromApi(HeadOfBusDevDashboardDto dto) {
    return HeadOfBusDevDashboardViewModel(
      blueprints: [
        StatGridBlueprint(dataPayload: [],
        ),
        ActivityFeedBlueprint(dataPayload: [],
        ),
      ],
    );
  }

  static HeadOfBusDevDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return HeadOfBusDevDashboardViewModel(
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
