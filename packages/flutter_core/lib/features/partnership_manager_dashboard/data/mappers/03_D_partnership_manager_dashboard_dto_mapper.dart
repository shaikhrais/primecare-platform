// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_partnership_manager_dashboard_dto_view_model.dart';
import '../dtos/02_M_partnership_manager_dashboard_dto_dto.dart';

class PartnershipManagerDashboardDtoMapper {
  static PartnershipManagerDashboardDtoViewModel fromDto(PartnershipManagerDashboardDtoDto dto) {
    return PartnershipManagerDashboardDtoViewModel(
      title: dto.raw['title']?.toString() ?? 'partnershipManagerDashboardDto',
      metadata: dto.raw,
    );
  }
}

