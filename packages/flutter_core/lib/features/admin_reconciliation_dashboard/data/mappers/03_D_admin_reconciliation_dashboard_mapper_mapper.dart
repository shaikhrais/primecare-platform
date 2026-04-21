// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_admin_reconciliation_dashboard_mapper_view_model.dart';
import '../dtos/02_M_admin_reconciliation_dashboard_mapper_dto.dart';

class AdminReconciliationDashboardMapperMapper {
  static AdminReconciliationDashboardMapperViewModel fromDto(AdminReconciliationDashboardMapperDto dto) {
    return AdminReconciliationDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'adminReconciliationDashboardMapper',
      metadata: dto.raw,
    );
  }
}

