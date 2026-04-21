// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_patient_dashboard_view_model_adapter_view_model.dart';
import '../dtos/02_M_patient_dashboard_view_model_adapter_dto.dart';

class PatientDashboardViewModelAdapterMapper {
  static PatientDashboardViewModelAdapterViewModel fromDto(PatientDashboardViewModelAdapterDto dto) {
    return PatientDashboardViewModelAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'patientDashboardViewModelAdapter',
      metadata: dto.raw,
    );
  }
}

