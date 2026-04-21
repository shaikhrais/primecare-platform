// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_compliance_manager_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_compliance_manager_dashboard_dto_adapter_dto.dart';

class ComplianceManagerDashboardDtoAdapterMapper {
  static ComplianceManagerDashboardDtoAdapterViewModel fromDto(ComplianceManagerDashboardDtoAdapterDto dto) {
    return ComplianceManagerDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'complianceManagerDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

