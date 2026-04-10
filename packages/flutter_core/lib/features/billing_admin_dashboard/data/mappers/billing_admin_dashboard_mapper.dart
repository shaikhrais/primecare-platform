import '../../domain/models/billing_admin_dashboard_view_model.dart';
import '../dtos/billing_admin_dashboard_dto.dart';

class BillingAdminDashboardMapper {
  static BillingAdminDashboardViewModel fromApi(BillingAdminDashboardDto dto) {
    return BillingAdminDashboardViewModel(kpis: dto.rawKpis);
  }

  static BillingAdminDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const BillingAdminDashboardViewModel();
  }
}
