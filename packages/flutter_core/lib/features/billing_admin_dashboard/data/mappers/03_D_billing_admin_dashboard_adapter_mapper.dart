// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_billing_admin_dashboard_adapter_view_model.dart';
import '../dtos/02_M_billing_admin_dashboard_adapter_dto.dart';

class BillingAdminDashboardAdapterMapper {
  static BillingAdminDashboardAdapterViewModel fromDto(BillingAdminDashboardAdapterDto dto) {
    return BillingAdminDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'billingAdminDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

