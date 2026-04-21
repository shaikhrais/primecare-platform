// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_ceo_dashboard_screen_view_model.dart';
import '../dtos/02_M_ceo_dashboard_screen_dto.dart';

class CeoDashboardScreenMapper {
  static CeoDashboardScreenViewModel fromDto(CeoDashboardScreenDto dto) {
    return CeoDashboardScreenViewModel(
      title: dto.raw['title']?.toString() ?? 'ceoDashboardScreen',
      metadata: dto.raw,
    );
  }
}

