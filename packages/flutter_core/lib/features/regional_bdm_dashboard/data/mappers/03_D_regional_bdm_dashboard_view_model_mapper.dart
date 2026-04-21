// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_regional_bdm_dashboard_view_model.dart';
import '../dtos/02_M_regional_bdm_dashboard_view_model_dto.dart';

class RegionalBdmDashboardViewModelMapper {
  static RegionalBdmDashboardViewModel fromDto(
    RegionalBdmDashboardViewModelDto dto,
  ) {
    return RegionalBdmDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'regionalBdmDashboardViewModel',
      metadata: dto.raw,
    );
  }
}
