// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_clinic_dashboard_mapper_view_model.dart';
import '../dtos/02_M_clinic_dashboard_mapper_dto.dart';

class ClinicDashboardMapperMapper {
  static ClinicDashboardMapperViewModel fromDto(ClinicDashboardMapperDto dto) {
    return ClinicDashboardMapperViewModel(
      title: dto.raw['title']?.toString() ?? 'clinicDashboardMapper',
      metadata: dto.raw,
    );
  }
}

