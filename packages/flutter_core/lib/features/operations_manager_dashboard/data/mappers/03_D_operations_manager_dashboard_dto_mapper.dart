// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_operations_manager_dashboard_dto_view_model.dart';
import '../dtos/02_M_operations_manager_dashboard_dto_dto.dart';

class OperationsManagerDashboardDtoMapper {
  static OperationsManagerDashboardDtoViewModel fromDto(OperationsManagerDashboardDtoDto dto) {
    return OperationsManagerDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'operationsManagerDashboardDto',
      metadata: dto.raw,
    );
  }
}

