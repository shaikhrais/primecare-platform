import '../../domain/models/territory_sales_manager_dashboard_view_model.dart';
import '../dtos/territory_sales_manager_dashboard_dto.dart';

class TerritorySalesManagerDashboardMapper {
  static TerritorySalesManagerDashboardViewModel fromApi(
    TerritorySalesManagerDashboardDto dto,
  ) {
    return TerritorySalesManagerDashboardViewModel(kpis: dto.rawKpis);
  }

  static TerritorySalesManagerDashboardViewModel fromMock(
    Map<String, dynamic> mock,
  ) {
    return const TerritorySalesManagerDashboardViewModel();
  }
}
