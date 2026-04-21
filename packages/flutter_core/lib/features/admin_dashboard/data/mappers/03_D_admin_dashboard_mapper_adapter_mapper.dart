// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_admin_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_admin_dashboard_mapper_adapter_dto.dart';

class AdminDashboardMapperAdapterMapper {
  static AdminDashboardMapperAdapterViewModel fromDto(AdminDashboardMapperAdapterDto dto) {
    return AdminDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'adminDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

