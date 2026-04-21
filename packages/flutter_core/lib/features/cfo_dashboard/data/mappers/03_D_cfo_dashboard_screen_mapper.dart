// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_cfo_dashboard_screen_view_model.dart';
import '../dtos/02_M_cfo_dashboard_screen_dto.dart';

class CfoDashboardScreenMapper {
  static CfoDashboardScreenViewModel fromDto(CfoDashboardScreenDto dto) {
    return CfoDashboardScreenViewModel(
      title: dto.raw['title']?.toString() ?? 'cfoDashboardScreen',
      metadata: dto.raw,
    );
  }
}

