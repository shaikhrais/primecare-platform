// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_patient_dashboard_adapter_view_model.dart';
import '../dtos/02_M_patient_dashboard_adapter_dto.dart';

class PatientDashboardAdapterMapper {
  static PatientDashboardAdapterViewModel fromDto(PatientDashboardAdapterDto dto) {
    return PatientDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'patientDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

