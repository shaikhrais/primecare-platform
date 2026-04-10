import '../../domain/models/compliance_manager_dashboard_view_model.dart';
import '../dtos/compliance_manager_dashboard_dto.dart';

class ComplianceManagerDashboardMapper {
  static ComplianceManagerDashboardViewModel fromApi(ComplianceManagerDashboardDto dto) {
    return ComplianceManagerDashboardViewModel(kpis: dto.rawKpis);
  }

  static ComplianceManagerDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const ComplianceManagerDashboardViewModel();
  }
}
