import '../../domain/models/general_manager_dashboard_view_model.dart';
import '../dtos/general_manager_dashboard_dto.dart';

class GeneralManagerDashboardMapper {
  static GeneralManagerDashboardViewModel fromApi(
    GeneralManagerDashboardDto dto,
  ) {
    return GeneralManagerDashboardViewModel(kpis: dto.rawKpis);
  }

  static GeneralManagerDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const GeneralManagerDashboardViewModel();
  }
}
