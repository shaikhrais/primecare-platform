// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_hr_hiring_dashboard_mapper_view_model.dart';
import '../dtos/02_M_hr_hiring_dashboard_mapper_dto.dart';

class HrHiringDashboardMapperMapper {
  static HrHiringDashboardMapperViewModel fromDto(HrHiringDashboardMapperDto dto) {
    return HrHiringDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'hrHiringDashboardMapper',
      metadata: dto.raw,
    );
  }
}

