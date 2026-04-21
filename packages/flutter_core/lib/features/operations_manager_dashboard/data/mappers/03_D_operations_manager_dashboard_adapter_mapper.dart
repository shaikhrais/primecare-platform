// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_operations_manager_dashboard_adapter_view_model.dart';
import '../dtos/02_M_operations_manager_dashboard_adapter_dto.dart';

class OperationsManagerDashboardAdapterMapper {
  static OperationsManagerDashboardAdapterViewModel fromDto(OperationsManagerDashboardAdapterDto dto) {
    return OperationsManagerDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'operationsManagerDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

