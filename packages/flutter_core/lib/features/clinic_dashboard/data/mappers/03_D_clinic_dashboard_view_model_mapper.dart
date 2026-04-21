// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_clinic_dashboard_view_model.dart';
import '../dtos/02_M_clinic_dashboard_view_model_dto.dart';

class ClinicDashboardViewModelMapper {
  static ClinicDashboardViewModel fromDto(ClinicDashboardViewModelDto dto) {
    return ClinicDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'clinicDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

