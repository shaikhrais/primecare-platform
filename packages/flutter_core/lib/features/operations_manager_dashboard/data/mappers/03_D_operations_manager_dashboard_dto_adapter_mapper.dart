// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_operations_manager_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_operations_manager_dashboard_dto_adapter_dto.dart';

class OperationsManagerDashboardDtoAdapterMapper {
  static OperationsManagerDashboardDtoAdapterViewModel fromDto(OperationsManagerDashboardDtoAdapterDto dto) {
    return OperationsManagerDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'operationsManagerDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

