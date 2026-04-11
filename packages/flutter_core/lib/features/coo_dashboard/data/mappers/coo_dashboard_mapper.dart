import '../../domain/models/coo_dashboard_view_model.dart';
import '../dtos/coo_dashboard_dto.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class CooDashboardMapper {
  static CooDashboardViewModel fromApi(CooDashboardDto dto) {
    return CooDashboardViewModel(
      blueprints: [
        StatGridBlueprint(dataPayload: [],
        ),
        ActivityFeedBlueprint(dataPayload: [],
        ),
      ],
    );
  }

  static CooDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return CooDashboardViewModel(
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
