import '../../domain/models/clinic_dashboard_view_model.dart';
import '../dtos/clinic_dashboard_dto.dart';

class ClinicDashboardMapper {
  static ClinicDashboardViewModel fromApi(ClinicDashboardDto dto) {
    return ClinicDashboardViewModel(kpis: dto.rawKpis);
  }

  static ClinicDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const ClinicDashboardViewModel();
  }
}
