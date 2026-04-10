import '../../domain/models/head_of_bus_dev_dashboard_view_model.dart';
import '../dtos/head_of_bus_dev_dashboard_dto.dart';

class HeadOfBusDevDashboardMapper {
  static HeadOfBusDevDashboardViewModel fromApi(HeadOfBusDevDashboardDto dto) {
    return HeadOfBusDevDashboardViewModel(kpis: dto.rawKpis);
  }

  static HeadOfBusDevDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const HeadOfBusDevDashboardViewModel();
  }
}
