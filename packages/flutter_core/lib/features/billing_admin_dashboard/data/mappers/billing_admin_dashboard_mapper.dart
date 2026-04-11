import '../../domain/models/billing_admin_dashboard_view_model.dart';
import '../dtos/billing_admin_dashboard_dto.dart';

class BillingAdminDashboardMapper {
  static BillingAdminDashboardViewModel fromApi(BillingAdminDashboardDto dto) {
    return BillingAdminDashboardViewModel(kpis: dto.rawKpis.map((k) => BillingAdminDashboardKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList());
  }

  static BillingAdminDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return BillingAdminDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
