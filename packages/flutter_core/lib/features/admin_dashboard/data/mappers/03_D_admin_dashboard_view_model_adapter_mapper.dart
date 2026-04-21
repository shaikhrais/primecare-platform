// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_admin_dashboard_view_model_adapter_view_model.dart';
import '../dtos/02_M_admin_dashboard_view_model_adapter_dto.dart';

class AdminDashboardViewModelAdapterMapper {
  static AdminDashboardViewModelAdapterViewModel fromDto(AdminDashboardViewModelAdapterDto dto) {
    return AdminDashboardViewModelAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'adminDashboardViewModelAdapter',
      metadata: dto.raw,
    );
  }
}

