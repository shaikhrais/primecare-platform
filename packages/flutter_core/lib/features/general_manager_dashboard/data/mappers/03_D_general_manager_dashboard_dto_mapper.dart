// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_general_manager_dashboard_dto_view_model.dart';
import '../dtos/02_M_general_manager_dashboard_dto_dto.dart';

class GeneralManagerDashboardDtoMapper {
  static GeneralManagerDashboardDtoViewModel fromDto(GeneralManagerDashboardDtoDto dto) {
    return GeneralManagerDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'generalManagerDashboardDto',
      metadata: dto.raw,
    );
  }
}

