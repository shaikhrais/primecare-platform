// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_regional_bdm_dashboard_dto_view_model.dart';
import '../dtos/02_M_regional_bdm_dashboard_dto_dto.dart';

class RegionalBdmDashboardDtoMapper {
  static RegionalBdmDashboardDtoViewModel fromDto(RegionalBdmDashboardDtoDto dto) {
    return RegionalBdmDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'regionalBdmDashboardDto',
      metadata: dto.raw,
    );
  }
}

