import '../../domain/models/client_dashboard_view_model.dart';
import '../dtos/client_dashboard_dto.dart';

class ClientDashboardMapper {
  static ClientDashboardViewModel fromApi(ClientDashboardDto dto) {
    return ClientDashboardViewModel(kpis: dto.rawKpis.map((k) => ClientDashboardKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList());
  }

  static ClientDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return ClientDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
