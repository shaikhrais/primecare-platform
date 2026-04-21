// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_regional_bdm_dashboard_provider_view_model.dart';
import '../dtos/02_M_regional_bdm_dashboard_provider_dto.dart';

class RegionalBdmDashboardProviderMapper {
  static RegionalBdmDashboardProviderViewModel fromDto(RegionalBdmDashboardProviderDto dto) {
    return RegionalBdmDashboardProviderViewModel(
      title: dto.raw['title']?.toString() ?? 'regionalBdmDashboardProvider',
      metadata: dto.raw,
    );
  }
}

