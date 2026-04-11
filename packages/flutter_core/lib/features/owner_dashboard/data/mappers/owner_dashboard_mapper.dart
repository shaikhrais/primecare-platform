import '../../domain/models/owner_dashboard_view_model.dart';
import '../dtos/owner_dashboard_dto.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class OwnerDashboardMapper {
  static OwnerDashboardViewModel fromApi(OwnerDashboardDto dto) {
    return OwnerDashboardViewModel(
      blueprints: [
        StatGridBlueprint(dataPayload: [],
        ),
        ActivityFeedBlueprint(dataPayload: [],
        ),
      ],
    );
  }

  static OwnerDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return OwnerDashboardViewModel(
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
