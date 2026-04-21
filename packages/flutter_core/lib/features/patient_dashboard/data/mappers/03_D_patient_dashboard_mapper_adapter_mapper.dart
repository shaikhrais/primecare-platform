// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_patient_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_patient_dashboard_mapper_adapter_dto.dart';

class PatientDashboardMapperAdapterMapper {
  static PatientDashboardMapperAdapterViewModel fromDto(PatientDashboardMapperAdapterDto dto) {
    return PatientDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'patientDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

