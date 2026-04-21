// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_operations_manager_dashboard_view_model.dart';
import '../dtos/02_M_operations_manager_dashboard_view_model_dto.dart';

class OperationsManagerDashboardViewModelMapper {
  static OperationsManagerDashboardViewModel fromDto(OperationsManagerDashboardViewModelDto dto) {
    return OperationsManagerDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'operationsManagerDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

