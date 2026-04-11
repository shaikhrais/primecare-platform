import '../../../../src/factory_floor/data_fallback_engine.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';
import '../../domain/models/territory_expansion_manager_dashboard_view_model.dart';
import '../dtos/territory_expansion_manager_dashboard_dto.dart';

class TerritoryExpansionManagerDashboardMapper {
  static TerritoryExpansionManagerDashboardViewModel fromApi(
    TerritoryExpansionManagerDashboardDto dto,
  ) {
    return TerritoryExpansionManagerDashboardViewModel(blueprints: [StatGridBlueprint(dataPayload: dto.rawKpis.map((k) => UniversalKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList())]);
  }

  static TerritoryExpansionManagerDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return TerritoryExpansionManagerDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
