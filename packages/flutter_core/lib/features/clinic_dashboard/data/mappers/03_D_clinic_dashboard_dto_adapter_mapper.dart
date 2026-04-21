// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_clinic_dashboard_dto_adapter_view_model.dart';
import '../dtos/02_M_clinic_dashboard_dto_adapter_dto.dart';

class ClinicDashboardDtoAdapterMapper {
  static ClinicDashboardDtoAdapterViewModel fromDto(ClinicDashboardDtoAdapterDto dto) {
    return ClinicDashboardDtoAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'clinicDashboardDtoAdapter',
      metadata: dto.raw,
    );
  }
}

