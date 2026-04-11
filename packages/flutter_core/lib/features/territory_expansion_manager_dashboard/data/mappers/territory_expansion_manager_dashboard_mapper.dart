import '../../domain/models/territory_expansion_manager_dashboard_view_model.dart';
import '../dtos/territory_expansion_manager_dashboard_dto.dart';

class TerritoryExpansionManagerDashboardMapper {
  static TerritoryExpansionManagerDashboardViewModel fromApi(
    TerritoryExpansionManagerDashboardDto dto,
  ) {
    return TerritoryExpansionManagerDashboardViewModel(kpis: dto.rawKpis.map((k) => TerritoryExpansionManagerDashboardKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList());
  }

  static TerritoryExpansionManagerDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return TerritoryExpansionManagerDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
