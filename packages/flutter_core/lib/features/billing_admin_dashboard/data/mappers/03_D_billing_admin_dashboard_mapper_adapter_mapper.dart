// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_billing_admin_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_billing_admin_dashboard_mapper_adapter_dto.dart';

class BillingAdminDashboardMapperAdapterMapper {
  static BillingAdminDashboardMapperAdapterViewModel fromDto(BillingAdminDashboardMapperAdapterDto dto) {
    return BillingAdminDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'billingAdminDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

