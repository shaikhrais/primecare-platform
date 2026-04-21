// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_general_manager_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_general_manager_dashboard_dto_adapter_dto.dart';

class GeneralManagerDashboardDtoAdapterMapper {
  static GeneralManagerDashboardDtoAdapterViewModel fromDto(GeneralManagerDashboardDtoAdapterDto dto) {
    return GeneralManagerDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'generalManagerDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

