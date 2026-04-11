import '../../domain/models/cfo_dashboard_view_model.dart';
import '../dtos/cfo_dashboard_dto.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class CfoDashboardMapper {
  static CfoDashboardViewModel fromApi(CfoDashboardDto dto) {
    return CfoDashboardViewModel(
      blueprints: [
        StatGridBlueprint(dataPayload: [],
        ),
        ActivityFeedBlueprint(dataPayload: [],
        ),
      ],
    );
  }

  static CfoDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return CfoDashboardViewModel(
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
