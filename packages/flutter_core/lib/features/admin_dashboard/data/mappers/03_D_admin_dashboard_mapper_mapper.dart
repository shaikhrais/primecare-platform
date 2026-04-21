// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_admin_dashboard_mapper_view_model.dart';
import '../dtos/02_M_admin_dashboard_mapper_dto.dart';

class AdminDashboardMapperMapper {
  static AdminDashboardMapperViewModel fromDto(AdminDashboardMapperDto dto) {
    return AdminDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'adminDashboardMapper',
      metadata: dto.raw,
    );
  }
}

