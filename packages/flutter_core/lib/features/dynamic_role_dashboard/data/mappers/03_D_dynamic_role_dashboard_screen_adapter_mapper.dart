// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_dynamic_role_dashboard_screen_adapter_view_model.dart';
import '../dtos/02_M_dynamic_role_dashboard_screen_adapter_dto.dart';

class DynamicRoleDashboardScreenAdapterMapper {
  static DynamicRoleDashboardScreenAdapterViewModel fromDto(DynamicRoleDashboardScreenAdapterDto dto) {
    return DynamicRoleDashboardScreenAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'dynamicRoleDashboardScreenAdapter',
      metadata: dto.raw,
    );
  }
}

