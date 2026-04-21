// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_demo_dashboard_screen_view_model.dart';
import '../dtos/02_M_demo_dashboard_screen_dto.dart';

class DemoDashboardScreenMapper {
  static DemoDashboardScreenViewModel fromDto(DemoDashboardScreenDto dto) {
    return DemoDashboardScreenViewModel(
      title: dto.raw['title']?.toString() ?? 'demoDashboardScreen',
      metadata: dto.raw,
    );
  }
}

