// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_admin_reconciliation_dashboard_dto_view_model.dart';
import '../dtos/02_M_admin_reconciliation_dashboard_dto_dto.dart';

class AdminReconciliationDashboardDtoMapper {
  static AdminReconciliationDashboardDtoViewModel fromDto(AdminReconciliationDashboardDtoDto dto) {
    return AdminReconciliationDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'adminReconciliationDashboardDto',
      metadata: dto.raw,
    );
  }
}

