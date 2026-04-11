import '../../domain/models/operations_manager_dashboard_view_model.dart';
import '../dtos/operations_manager_dashboard_dto.dart';

class OperationsManagerDashboardMapper {
  static OperationsManagerDashboardViewModel fromApi(
    OperationsManagerDashboardDto dto,
  ) {
    return OperationsManagerDashboardViewModel(kpis: dto.rawKpis.map((k) => OperationsManagerDashboardKpi(
        title: k['name']?.toString() ?? '',
        value: k['val']?.toString() ?? '0',
        trend: k['trend']?.toString(),
        status: k['status']?.toString() ?? 'Active',
      )).toList());
  }

  static OperationsManagerDashboardViewModel fromMock(Map<String, dynamic> mock, {bool isErrorFallback = false}) {
    return OperationsManagerDashboardViewModel(isOfflineFallback: isErrorFallback);
  }
}
