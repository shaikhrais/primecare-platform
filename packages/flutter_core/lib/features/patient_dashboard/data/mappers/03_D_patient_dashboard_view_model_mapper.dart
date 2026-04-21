// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/03_V_patient_dashboard_view_model.dart';
import '../dtos/02_M_patient_dashboard_view_model_dto.dart';

class PatientDashboardViewModelMapper {
  static PatientDashboardViewModel fromDto(PatientDashboardViewModelDto dto) {
    return PatientDashboardViewModel(
      title: dto.raw['title']?.toString() ?? 'patientDashboardViewModel',
      metadata: dto.raw,
    );
  }
}

