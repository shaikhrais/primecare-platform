// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_customer_support_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_customer_support_dashboard_dto_adapter_dto.dart';

class CustomerSupportDashboardDtoAdapterMapper {
  static CustomerSupportDashboardDtoAdapterViewModel fromDto(CustomerSupportDashboardDtoAdapterDto dto) {
    return CustomerSupportDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'customerSupportDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

