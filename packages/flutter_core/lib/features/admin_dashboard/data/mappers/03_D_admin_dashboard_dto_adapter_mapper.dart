// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_admin_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_admin_dashboard_dto_adapter_dto.dart';

class AdminDashboardDtoAdapterMapper {
  static AdminDashboardDtoAdapterViewModel fromDto(AdminDashboardDtoAdapterDto dto) {
    return AdminDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'adminDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

