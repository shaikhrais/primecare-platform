// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_billing_admin_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_billing_admin_dashboard_dto_adapter_dto.dart';

class BillingAdminDashboardDtoAdapterMapper {
  static BillingAdminDashboardDtoAdapterViewModel fromDto(BillingAdminDashboardDtoAdapterDto dto) {
    return BillingAdminDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'billingAdminDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

