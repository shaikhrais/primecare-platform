import '../../domain/models/territory_expansion_manager_dashboard_view_model.dart';
import '../dtos/territory_expansion_manager_dashboard_dto.dart';

class TerritoryExpansionManagerDashboardMapper {
  static TerritoryExpansionManagerDashboardViewModel fromApi(
    TerritoryExpansionManagerDashboardDto dto,
  ) {
    return TerritoryExpansionManagerDashboardViewModel(kpis: dto.rawKpis);
  }

  static TerritoryExpansionManagerDashboardViewModel fromMock(
    Map<String, dynamic> mock,
  ) {
    return const TerritoryExpansionManagerDashboardViewModel();
  }
}
