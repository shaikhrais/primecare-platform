import '../../domain/models/ceo_dashboard_view_model.dart';
import '../dtos/ceo_dashboard_dto.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class CeoDashboardMapper {
  static CeoDashboardViewModel fromApi(CeoDashboardDto dto) {
    return CeoDashboardViewModel(
      blueprints: [
        StatGridBlueprint(dataPayload: [],
        ),
        ActivityFeedBlueprint(dataPayload: [],
        ),
      ],
    );
  }

  static CeoDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return CeoDashboardViewModel(
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
