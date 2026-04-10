import '../../domain/models/customer_support_dashboard_view_model.dart';
import '../dtos/customer_support_dashboard_dto.dart';

class CustomerSupportDashboardMapper {
  static CustomerSupportDashboardViewModel fromApi(CustomerSupportDashboardDto dto) {
    return CustomerSupportDashboardViewModel(kpis: dto.rawKpis);
  }

  static CustomerSupportDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const CustomerSupportDashboardViewModel();
  }
}
