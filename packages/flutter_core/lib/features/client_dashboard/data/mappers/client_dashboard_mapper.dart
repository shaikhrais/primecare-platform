import '../../domain/models/client_dashboard_view_model.dart';
import '../dtos/client_dashboard_dto.dart';

class ClientDashboardMapper {
  static ClientDashboardViewModel fromApi(ClientDashboardDto dto) {
    return ClientDashboardViewModel(kpis: dto.rawKpis);
  }

  static ClientDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const ClientDashboardViewModel();
  }
}
