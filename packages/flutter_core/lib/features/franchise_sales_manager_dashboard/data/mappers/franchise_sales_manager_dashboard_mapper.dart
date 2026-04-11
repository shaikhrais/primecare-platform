import '../../domain/models/franchise_sales_manager_dashboard_view_model.dart';
import '../dtos/franchise_sales_manager_dashboard_dto.dart';

class FranchiseSalesManagerDashboardMapper {
  static FranchiseSalesManagerDashboardViewModel fromApi(
    FranchiseSalesManagerDashboardDto dto,
  ) {
    return FranchiseSalesManagerDashboardViewModel(kpis: dto.rawKpis.map((k) => FranchiseSalesManagerDashboardKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList());
  }

  static FranchiseSalesManagerDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return FranchiseSalesManagerDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
