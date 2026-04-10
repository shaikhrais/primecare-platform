import '../../domain/models/hr_hiring_dashboard_view_model.dart';
import '../dtos/hr_hiring_dashboard_dto.dart';

class HrHiringDashboardMapper {
  static HrHiringDashboardViewModel fromApi(HrHiringDashboardDto dto) {
    return HrHiringDashboardViewModel(kpis: dto.rawKpis);
  }

  static HrHiringDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const HrHiringDashboardViewModel();
  }
}
