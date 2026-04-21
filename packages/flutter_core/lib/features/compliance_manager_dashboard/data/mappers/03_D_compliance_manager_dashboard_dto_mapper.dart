// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_compliance_manager_dashboard_dto_view_model.dart';
import '../dtos/02_M_compliance_manager_dashboard_dto_dto.dart';

class ComplianceManagerDashboardDtoMapper {
  static ComplianceManagerDashboardDtoViewModel fromDto(ComplianceManagerDashboardDtoDto dto) {
    return ComplianceManagerDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'complianceManagerDashboardDto',
      metadata: dto.raw,
    );
  }
}

