// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_hr_hiring_dashboard_adapter_view_model.dart';
import '../dtos/02_M_hr_hiring_dashboard_adapter_dto.dart';

class HrHiringDashboardAdapterMapper {
  static HrHiringDashboardAdapterViewModel fromDto(HrHiringDashboardAdapterDto dto) {
    return HrHiringDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'hrHiringDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

