// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_compliance_manager_dashboard_view_model.dart';
import '../dtos/02_M_compliance_manager_dashboard_view_model_dto.dart';

class ComplianceManagerDashboardViewModelMapper {
  static ComplianceManagerDashboardViewModel fromDto(
    ComplianceManagerDashboardViewModelDto dto,
  ) {
    return ComplianceManagerDashboardViewModel(
      title:
          dto.raw['title']?.toString() ?? 'complianceManagerDashboardViewModel',
      metadata: dto.raw,
    );
  }
}
