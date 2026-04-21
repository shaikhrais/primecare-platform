// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_hr_hiring_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_hr_hiring_dashboard_dto_adapter_dto.dart';

class HrHiringDashboardDtoAdapterMapper {
  static HrHiringDashboardDtoAdapterViewModel fromDto(HrHiringDashboardDtoAdapterDto dto) {
    return HrHiringDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'hrHiringDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

