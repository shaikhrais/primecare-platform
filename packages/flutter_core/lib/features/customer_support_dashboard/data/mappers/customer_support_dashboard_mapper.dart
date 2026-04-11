import '../../domain/models/customer_support_dashboard_view_model.dart';
import '../dtos/customer_support_dashboard_dto.dart';

class CustomerSupportDashboardMapper {
  static CustomerSupportDashboardViewModel fromApi(
    CustomerSupportDashboardDto dto,
  ) {
    return CustomerSupportDashboardViewModel(kpis: dto.rawKpis.map((k) => CustomerSupportDashboardKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList());
  }

  static CustomerSupportDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return CustomerSupportDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
