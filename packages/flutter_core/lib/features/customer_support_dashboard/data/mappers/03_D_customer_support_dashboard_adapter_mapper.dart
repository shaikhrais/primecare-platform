// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_customer_support_dashboard_adapter_view_model.dart';
import '../dtos/02_M_customer_support_dashboard_adapter_dto.dart';

class CustomerSupportDashboardAdapterMapper {
  static CustomerSupportDashboardAdapterViewModel fromDto(CustomerSupportDashboardAdapterDto dto) {
    return CustomerSupportDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'customerSupportDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

