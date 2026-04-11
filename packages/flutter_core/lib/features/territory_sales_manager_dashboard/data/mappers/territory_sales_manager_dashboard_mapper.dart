import '../../../../src/factory_floor/data_fallback_engine.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';
import '../../domain/models/territory_sales_manager_dashboard_view_model.dart';
import '../dtos/territory_sales_manager_dashboard_dto.dart';

class TerritorySalesManagerDashboardMapper {
  static TerritorySalesManagerDashboardViewModel fromApi(
    TerritorySalesManagerDashboardDto dto,
  ) {
    return TerritorySalesManagerDashboardViewModel(blueprints: [StatGridBlueprint(dataPayload: dto.rawKpis.map((k) => UniversalKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList())]);
  }

  static TerritorySalesManagerDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return TerritorySalesManagerDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
