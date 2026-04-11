import '../../domain/models/family_dashboard_view_model.dart';
import '../dtos/family_dashboard_dto.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class FamilyDashboardMapper {
  static FamilyDashboardViewModel fromApi(FamilyDashboardDto dto) {
    return FamilyDashboardViewModel(
      blueprints: [
        StatGridBlueprint(dataPayload: [],
        ),
        ActivityFeedBlueprint(dataPayload: [],
        ),
      ],
    );
  }

  static FamilyDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return FamilyDashboardViewModel(
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
