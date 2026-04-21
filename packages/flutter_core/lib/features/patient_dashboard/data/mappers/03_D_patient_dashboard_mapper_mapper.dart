// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_patient_dashboard_mapper_view_model.dart';
import '../dtos/02_M_patient_dashboard_mapper_dto.dart';

class PatientDashboardMapperMapper {
  static PatientDashboardMapperViewModel fromDto(PatientDashboardMapperDto dto) {
    return PatientDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'patientDashboardMapper',
      metadata: dto.raw,
    );
  }
}

