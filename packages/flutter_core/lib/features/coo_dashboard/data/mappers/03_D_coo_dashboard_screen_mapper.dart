// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_coo_dashboard_screen_view_model.dart';
import '../dtos/02_M_coo_dashboard_screen_dto.dart';

class CooDashboardScreenMapper {
  static CooDashboardScreenViewModel fromDto(CooDashboardScreenDto dto) {
    return CooDashboardScreenViewModel(
      title: dto.raw['title']?.toString() ?? 'cooDashboardScreen',
      metadata: dto.raw,
    );
  }
}

