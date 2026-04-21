// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_regional_bdm_dashboard_screen_view_model.dart';
import '../dtos/02_M_regional_bdm_dashboard_screen_dto.dart';

class RegionalBdmDashboardScreenMapper {
  static RegionalBdmDashboardScreenViewModel fromDto(RegionalBdmDashboardScreenDto dto) {
    return RegionalBdmDashboardScreenViewModel(
      title: dto.raw['title']?.toString() ?? 'regionalBdmDashboardScreen',
      metadata: dto.raw,
    );
  }
}

