// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_billing_admin_dashboard_dto_view_model.dart';
import '../dtos/02_M_billing_admin_dashboard_dto_dto.dart';

class BillingAdminDashboardDtoMapper {
  static BillingAdminDashboardDtoViewModel fromDto(BillingAdminDashboardDtoDto dto) {
    return BillingAdminDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'billingAdminDashboardDto',
      metadata: dto.raw,
    );
  }
}

