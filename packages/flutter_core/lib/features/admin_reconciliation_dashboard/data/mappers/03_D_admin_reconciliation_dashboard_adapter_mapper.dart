// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_admin_reconciliation_dashboard_adapter_view_model.dart';
import '../dtos/02_M_admin_reconciliation_dashboard_adapter_dto.dart';

class AdminReconciliationDashboardAdapterMapper {
  static AdminReconciliationDashboardAdapterViewModel fromDto(AdminReconciliationDashboardAdapterDto dto) {
    return AdminReconciliationDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'adminReconciliationDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

