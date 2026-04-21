// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_general_manager_dashboard_adapter_view_model.dart';
import '../dtos/02_M_general_manager_dashboard_adapter_dto.dart';

class GeneralManagerDashboardAdapterMapper {
  static GeneralManagerDashboardAdapterViewModel fromDto(GeneralManagerDashboardAdapterDto dto) {
    return GeneralManagerDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'generalManagerDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

