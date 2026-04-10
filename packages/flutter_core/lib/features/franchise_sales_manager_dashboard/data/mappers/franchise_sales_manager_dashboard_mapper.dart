import '../../domain/models/franchise_sales_manager_dashboard_view_model.dart';
import '../dtos/franchise_sales_manager_dashboard_dto.dart';

class FranchiseSalesManagerDashboardMapper {
  static FranchiseSalesManagerDashboardViewModel fromApi(FranchiseSalesManagerDashboardDto dto) {
    return FranchiseSalesManagerDashboardViewModel(kpis: dto.rawKpis);
  }

  static FranchiseSalesManagerDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const FranchiseSalesManagerDashboardViewModel();
  }
}
