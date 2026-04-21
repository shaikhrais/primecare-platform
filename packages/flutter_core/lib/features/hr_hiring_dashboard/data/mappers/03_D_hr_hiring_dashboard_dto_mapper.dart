// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_hr_hiring_dashboard_dto_view_model.dart';
import '../dtos/02_M_hr_hiring_dashboard_dto_dto.dart';

class HrHiringDashboardDtoMapper {
  static HrHiringDashboardDtoViewModel fromDto(HrHiringDashboardDtoDto dto) {
    return HrHiringDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'hrHiringDashboardDto',
      metadata: dto.raw,
    );
  }
}

