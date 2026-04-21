// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_billing_admin_dashboard_mapper_view_model.dart';
import '../dtos/02_M_billing_admin_dashboard_mapper_dto.dart';

class BillingAdminDashboardMapperMapper {
  static BillingAdminDashboardMapperViewModel fromDto(BillingAdminDashboardMapperDto dto) {
    return BillingAdminDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'billingAdminDashboardMapper',
      metadata: dto.raw,
    );
  }
}

