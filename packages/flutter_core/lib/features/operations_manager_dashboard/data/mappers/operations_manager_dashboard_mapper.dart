import '../../domain/models/operations_manager_dashboard_view_model.dart';
import '../dtos/operations_manager_dashboard_dto.dart';

class OperationsManagerDashboardMapper {
  static OperationsManagerDashboardViewModel fromApi(OperationsManagerDashboardDto dto) {
    return OperationsManagerDashboardViewModel(kpis: dto.rawKpis);
  }

  static OperationsManagerDashboardViewModel fromMock(Map<String, dynamic> mock) {
    return const OperationsManagerDashboardViewModel();
  }
}
