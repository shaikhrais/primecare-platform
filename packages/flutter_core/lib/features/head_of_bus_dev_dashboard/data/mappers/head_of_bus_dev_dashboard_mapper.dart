import '../../domain/models/head_of_bus_dev_dashboard_view_model.dart';
import '../dtos/head_of_bus_dev_dashboard_dto.dart';

class HeadOfBusDevDashboardMapper {
  static HeadOfBusDevDashboardViewModel fromApi(HeadOfBusDevDashboardDto dto) {
    return HeadOfBusDevDashboardViewModel(kpis: dto.rawKpis.map((k) => HeadOfBusDevDashboardKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList());
  }

  static HeadOfBusDevDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return HeadOfBusDevDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
