// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_compliance_manager_dashboard_mapper_view_model.dart';
import '../dtos/02_M_compliance_manager_dashboard_mapper_dto.dart';

class ComplianceManagerDashboardMapperMapper {
  static ComplianceManagerDashboardMapperViewModel fromDto(ComplianceManagerDashboardMapperDto dto) {
    return ComplianceManagerDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'complianceManagerDashboardMapper',
      metadata: dto.raw,
    );
  }
}

