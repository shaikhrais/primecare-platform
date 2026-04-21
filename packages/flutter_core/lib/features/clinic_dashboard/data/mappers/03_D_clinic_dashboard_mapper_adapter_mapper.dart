// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_clinic_dashboard_mapper_adapter_view_model.dart';
import '../dtos/02_M_clinic_dashboard_mapper_adapter_dto.dart';

class ClinicDashboardMapperAdapterMapper {
  static ClinicDashboardMapperAdapterViewModel fromDto(ClinicDashboardMapperAdapterDto dto) {
    return ClinicDashboardMapperAdapterViewModel(
      title: dto.raw['title']?.toString() ?? 'clinicDashboardMapperAdapter',
      metadata: dto.raw,
    );
  }
}

