// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_hr_hiring_dashboard_view_model_adapter_view_model.dart';
import '../dtos/02_M_hr_hiring_dashboard_view_model_adapter_dto.dart';

class HrHiringDashboardViewModelAdapterMapper {
  static HrHiringDashboardViewModelAdapterViewModel fromDto(HrHiringDashboardViewModelAdapterDto dto) {
    return HrHiringDashboardViewModelAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'hrHiringDashboardViewModelAdapter',
      metadata: dto.raw,
    );
  }
}

