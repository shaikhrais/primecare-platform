// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_hr_hiring_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_hr_hiring_dashboard_mapper_adapter_dto.dart';

class HrHiringDashboardMapperAdapterMapper {
  static HrHiringDashboardMapperAdapterViewModel fromDto(HrHiringDashboardMapperAdapterDto dto) {
    return HrHiringDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'hrHiringDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

