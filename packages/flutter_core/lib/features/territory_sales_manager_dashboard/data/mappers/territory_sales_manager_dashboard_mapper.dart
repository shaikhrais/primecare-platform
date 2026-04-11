import '../../domain/models/territory_sales_manager_dashboard_view_model.dart';
import '../dtos/territory_sales_manager_dashboard_dto.dart';

class TerritorySalesManagerDashboardMapper {
  static TerritorySalesManagerDashboardViewModel fromApi(
    TerritorySalesManagerDashboardDto dto,
  ) {
    return TerritorySalesManagerDashboardViewModel(kpis: dto.rawKpis.map((k) => TerritorySalesManagerDashboardKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList());
  }

  static TerritorySalesManagerDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return TerritorySalesManagerDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
