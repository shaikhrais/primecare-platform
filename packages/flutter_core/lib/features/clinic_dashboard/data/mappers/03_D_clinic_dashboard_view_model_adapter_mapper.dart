// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_clinic_dashboard_view_model_adapter_view_model.dart';
import '../dtos/02_M_clinic_dashboard_view_model_adapter_dto.dart';

class ClinicDashboardViewModelAdapterMapper {
  static ClinicDashboardViewModelAdapterViewModel fromDto(ClinicDashboardViewModelAdapterDto dto) {
    return ClinicDashboardViewModelAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'clinicDashboardViewModelAdapter',
      metadata: dto.raw,
    );
  }
}

