// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_admin_dashboard_dto_view_model.dart';
import '../dtos/02_M_admin_dashboard_dto_dto.dart';

class AdminDashboardDtoMapper {
  static AdminDashboardDtoViewModel fromDto(AdminDashboardDtoDto dto) {
    return AdminDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'adminDashboardDto',
      metadata: dto.raw,
    );
  }
}

