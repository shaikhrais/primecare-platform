// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_regional_manager_ontario_dashboard_dto_view_model.dart';
import '../dtos/02_M_regional_manager_ontario_dashboard_dto_dto.dart';

class RegionalManagerOntarioDashboardDtoMapper {
  static RegionalManagerOntarioDashboardDtoViewModel fromDto(RegionalManagerOntarioDashboardDtoDto dto) {
    return RegionalManagerOntarioDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'regionalManagerOntarioDashboardDto',
      metadata: dto.raw,
    );
  }
}

