// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_clinic_dashboard_adapter_view_model.dart';
import '../dtos/02_M_clinic_dashboard_adapter_dto.dart';

class ClinicDashboardAdapterMapper {
  static ClinicDashboardAdapterViewModel fromDto(ClinicDashboardAdapterDto dto) {
    return ClinicDashboardAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'clinicDashboardAdapter',
      metadata: dto.raw,
    );
  }
}

