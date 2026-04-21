// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_customer_support_dashboard_dto_view_model.dart';
import '../dtos/02_M_customer_support_dashboard_dto_dto.dart';

class CustomerSupportDashboardDtoMapper {
  static CustomerSupportDashboardDtoViewModel fromDto(CustomerSupportDashboardDtoDto dto) {
    return CustomerSupportDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'customerSupportDashboardDto',
      metadata: dto.raw,
    );
  }
}

