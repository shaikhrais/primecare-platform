// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_patient_dashboard_dto_view_model.dart';
import '../dtos/02_M_patient_dashboard_dto_dto.dart';

class PatientDashboardDtoMapper {
  static PatientDashboardDtoViewModel fromDto(PatientDashboardDtoDto dto) {
    return PatientDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'patientDashboardDto',
      metadata: dto.raw,
    );
  }
}

