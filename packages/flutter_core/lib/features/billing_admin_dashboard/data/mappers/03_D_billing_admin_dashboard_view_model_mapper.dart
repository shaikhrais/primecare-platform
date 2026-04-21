// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_billing_admin_dashboard_view_model.dart';
import '../dtos/02_M_billing_admin_dashboard_view_model_dto.dart';

class BillingAdminDashboardViewModelMapper {
  static BillingAdminDashboardViewModel fromDto(
    BillingAdminDashboardViewModelDto dto,
  ) {
    return BillingAdminDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'billingAdminDashboardViewModel',
      metadata: dto.raw,
    );
  }
}
