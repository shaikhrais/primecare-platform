// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_patient_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_patient_dashboard_dto_adapter_dto.dart';

class PatientDashboardDtoAdapterMapper {
  static PatientDashboardDtoAdapterViewModel fromDto(PatientDashboardDtoAdapterDto dto) {
    return PatientDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'patientDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

