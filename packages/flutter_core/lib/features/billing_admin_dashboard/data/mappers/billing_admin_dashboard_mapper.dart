import '../../domain/models/billing_admin_dashboard_view_model.dart';
import '../dtos/billing_admin_dashboard_dto.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class BillingAdminDashboardMapper {
  static BillingAdminDashboardViewModel fromApi(BillingAdminDashboardDto dto) {
    return BillingAdminDashboardViewModel(
      blueprints: [
        StatGridBlueprint(dataPayload: [],
        ),
        ActivityFeedBlueprint(dataPayload: [],
        ),
      ],
    );
  }

  static BillingAdminDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return BillingAdminDashboardViewModel(
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
