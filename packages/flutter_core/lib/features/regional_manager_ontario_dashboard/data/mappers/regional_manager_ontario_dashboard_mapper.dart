import '../../domain/models/regional_manager_ontario_dashboard_view_model.dart';
import '../dtos/regional_manager_ontario_dashboard_dto.dart';

class RegionalManagerOntarioDashboardMapper {
  static RegionalManagerOntarioDashboardViewModel fromApi(RegionalManagerOntarioDashboardDto dto) {
    return RegionalManagerOntarioDashboardViewModel(kpis: dto.rawKpis);
  }

  static RegionalManagerOntarioDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const RegionalManagerOntarioDashboardViewModel();
  }
}
