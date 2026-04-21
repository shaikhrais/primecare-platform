// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_compliance_manager_dashboard_adapter_view_model.dart';
import '../dtos/02_M_compliance_manager_dashboard_adapter_dto.dart';

class ComplianceManagerDashboardAdapterMapper {
  static ComplianceManagerDashboardAdapterViewModel fromDto(ComplianceManagerDashboardAdapterDto dto) {
    return ComplianceManagerDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'complianceManagerDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

