// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_customer_support_dashboard_view_model.dart';
import '../dtos/02_M_customer_support_dashboard_view_model_dto.dart';

class CustomerSupportDashboardViewModelMapper {
  static CustomerSupportDashboardViewModel fromDto(CustomerSupportDashboardViewModelDto dto) {
    return CustomerSupportDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'customerSupportDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

