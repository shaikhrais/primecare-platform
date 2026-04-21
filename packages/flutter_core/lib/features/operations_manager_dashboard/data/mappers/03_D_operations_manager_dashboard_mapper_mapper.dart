// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_operations_manager_dashboard_mapper_view_model.dart';
import '../dtos/02_M_operations_manager_dashboard_mapper_dto.dart';

class OperationsManagerDashboardMapperMapper {
  static OperationsManagerDashboardMapperViewModel fromDto(OperationsManagerDashboardMapperDto dto) {
    return OperationsManagerDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'operationsManagerDashboardMapper',
      metadata: dto.raw,
    );
  }
}

