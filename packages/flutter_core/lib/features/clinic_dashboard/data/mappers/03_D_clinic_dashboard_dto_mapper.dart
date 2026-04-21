// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_clinic_dashboard_dto_view_model.dart';
import '../dtos/02_M_clinic_dashboard_dto_dto.dart';

class ClinicDashboardDtoMapper {
  static ClinicDashboardDtoViewModel fromDto(ClinicDashboardDtoDto dto) {
    return ClinicDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'clinicDashboardDto',
      metadata: dto.raw,
    );
  }
}

