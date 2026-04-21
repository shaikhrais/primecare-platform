// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_dynamic_role_dashboard_screen_view_model.dart';
import '../dtos/02_M_dynamic_role_dashboard_screen_dto.dart';

class DynamicRoleDashboardScreenMapper {
  static DynamicRoleDashboardScreenViewModel fromDto(DynamicRoleDashboardScreenDto dto) {
    return DynamicRoleDashboardScreenViewModel(
      title: dto.raw['title']?.toString() ?? 'dynamicRoleDashboardScreen',
      metadata: dto.raw,
    );
  }
}

