// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_general_manager_dashboard_view_model.dart';
import '../dtos/02_M_general_manager_dashboard_view_model_dto.dart';

class GeneralManagerDashboardViewModelMapper {
  static GeneralManagerDashboardViewModel fromDto(GeneralManagerDashboardViewModelDto dto) {
    return GeneralManagerDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'generalManagerDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

