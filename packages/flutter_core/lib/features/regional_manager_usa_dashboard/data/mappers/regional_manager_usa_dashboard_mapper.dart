import '../../domain/models/regional_manager_usa_dashboard_view_model.dart';
import '../dtos/regional_manager_usa_dashboard_dto.dart';

class RegionalManagerUsaDashboardMapper {
  static RegionalManagerUsaDashboardViewModel fromApi(RegionalManagerUsaDashboardDto dto) {
    return RegionalManagerUsaDashboardViewModel(kpis: dto.rawKpis);
  }

  static RegionalManagerUsaDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const RegionalManagerUsaDashboardViewModel();
  }
}
