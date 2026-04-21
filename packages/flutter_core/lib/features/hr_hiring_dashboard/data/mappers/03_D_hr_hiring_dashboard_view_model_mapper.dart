// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_hr_hiring_dashboard_view_model.dart';
import '../dtos/02_M_hr_hiring_dashboard_view_model_dto.dart';

class HrHiringDashboardViewModelMapper {
  static HrHiringDashboardViewModel fromDto(HrHiringDashboardViewModelDto dto) {
    return HrHiringDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'hrHiringDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

