// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_customer_support_dashboard_mapper_view_model.dart';
import '../dtos/02_M_customer_support_dashboard_mapper_dto.dart';

class CustomerSupportDashboardMapperMapper {
  static CustomerSupportDashboardMapperViewModel fromDto(CustomerSupportDashboardMapperDto dto) {
    return CustomerSupportDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'customerSupportDashboardMapper',
      metadata: dto.raw,
    );
  }
}

