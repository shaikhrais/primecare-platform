// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_regional_bdm_dashboard_mapper_view_model.dart';
import '../dtos/02_M_regional_bdm_dashboard_mapper_dto.dart';

class RegionalBdmDashboardMapperMapper {
  static RegionalBdmDashboardMapperViewModel fromDto(RegionalBdmDashboardMapperDto dto) {
    return RegionalBdmDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'regionalBdmDashboardMapper',
      metadata: dto.raw,
    );
  }
}

