// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_admin_dashboard_adapter_view_model.dart';
import '../dtos/02_M_admin_dashboard_adapter_dto.dart';

class AdminDashboardAdapterMapper {
  static AdminDashboardAdapterViewModel fromDto(AdminDashboardAdapterDto dto) {
    return AdminDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'adminDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

