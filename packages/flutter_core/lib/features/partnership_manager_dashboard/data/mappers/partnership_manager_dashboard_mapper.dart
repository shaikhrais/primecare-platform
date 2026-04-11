import '../../../../src/factory_floor/data_fallback_engine.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';
import '../../domain/models/partnership_manager_dashboard_view_model.dart';
import '../dtos/partnership_manager_dashboard_dto.dart';

class PartnershipManagerDashboardMapper {
  static PartnershipManagerDashboardViewModel fromApi(
    PartnershipManagerDashboardDto dto,
  ) {
    return PartnershipManagerDashboardViewModel(blueprints: [StatGridBlueprint(dataPayload: dto.rawKpis.map((k) => UniversalKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList())]);
  }

  static PartnershipManagerDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return PartnershipManagerDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
