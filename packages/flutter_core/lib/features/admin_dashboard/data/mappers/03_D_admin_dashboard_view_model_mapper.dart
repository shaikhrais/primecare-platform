// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_admin_dashboard_view_model.dart';
import '../dtos/02_M_admin_dashboard_view_model_dto.dart';

class AdminDashboardViewModelMapper {
  static AdminDashboardViewModel fromDto(AdminDashboardViewModelDto dto) {
    return AdminDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'adminDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

